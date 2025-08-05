class RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.class.transaction do
      resource.save
      yield resource if block_given?
      if resource.persisted?
        puts "Received token: #{params.dig(:payment, :token)}"

        @payment = Payment.new(
          {email: params["user"]["email"],
          token: params[:payment]["token"],
          user_id: resource.id})
        
        flash[:error] = "Please check registration errors" unless @payment.valid?

        # Handle payment processing
        begin
          payment = @payment.process_payment
          payment.save
        rescue Exception => e
          flash[:error] = e.message
          resource.destroy
          puts "Payment failed: #{e.message}"
          redirect_to new_user_registration_path, alert: e.message and return
        end

        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, payment_attributes: [:card_number, :card_cvc, :card_expires_month, :card_expires_year]])
  end
end