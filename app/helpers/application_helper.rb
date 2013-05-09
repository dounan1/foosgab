module ApplicationHelper
  def nav_link(text, path)
    css = current_page?(path) ? 'active' : ''

    content_tag(:li, class: css) do
      link_to text, path
    end
  end

  def avatar_tag(user)
    if user.avatar_url.present?
      url = user.avatar_url
    else
      default_url = asset_url('default.png')
      if user.email.present?
        url = "http://gravatar.com/avatar/#{Digest::MD5::hexdigest(user.email).downcase}.png?s=210"#d=#{CGI.escape(default_url)}"
      else
        url = default_url
      end
    end

    image_tag url, size: '250x250', class: 'avatar'
  end

end