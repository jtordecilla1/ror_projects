module ApplicationHelper
  def gravatar_for(user, styles = "")
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    gravatar_url = "https://www.gravatar.com/avatar/1fa5179e213142ea9454a554fb7f4806"
    #gravatar_url = "https://www.gravatar.com/avatar/#{hash}"
    image_tag(gravatar_url, alt: user.username, class: "rounded mx-auto d-block #{styles}")
  end
end