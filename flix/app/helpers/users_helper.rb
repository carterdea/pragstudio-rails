module UsersHelper
  def profile_image_for(user, options={})
    size = options[:size] || 80
    gravatar_url = "http://secure.gravatar.com/avatar/" + user.gravatar_id + "?s=" + size.to_s
    image_tag(gravatar_url, alt: user.name)
  end
end
