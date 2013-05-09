module ApplicationHelper
  def nav_link(text, path)
    css = current_page?(path) ? 'active' : ''

    content_tag(:li, class: css) do
      link_to text, path
    end
  end

  def avatar_tag(player, opts={})
    opts[:size] ||= 250

    if player.avatar_url.present?
      url = player.avatar_url
    else
      default_url = asset_url('default.png')
      if player.email.present?
        url = "http://gravatar.com/avatar/#{Digest::MD5::hexdigest(player.email).downcase}.png?s=#{opts[:size]}&d=#{CGI.escape(default_url)}"
      else
        url = default_url
      end
    end

    size = opts[:size].to_s + 'x' + opts[:size].to_s
    link_to image_tag(url, size: size, class: 'avatar'), player
  end

end