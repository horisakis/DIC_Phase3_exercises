module UsersHelper
  def get_icon(user)
    if user.icon.url
      image_tag(user.icon, class: 'user-icon-image')
    else
      image_tag('icon_default.png', class: 'user-icon-image')
    end
  end

end
