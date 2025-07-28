class MessagesController < ApplicationController
    before_action :require_user
  
    def create
      @message = current_user.messages.build(message_params)
      if @message.save
        ActionCable.server.broadcast "chatroom_channel", {
          mod_message: message_render(@message),
          user: @message.user.username
        }
        redirect_to root_path
      else
        redirect_to root_path, alert: "Message could not be sent"
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:body)
    end

    def message_render(message)
      ApplicationController.render(partial: "messages/message", locals: { message: message })
    end
  end