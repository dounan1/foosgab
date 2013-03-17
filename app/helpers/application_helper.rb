module ApplicationHelper

  def nav_link(text, path)
    css = current_page?(path) ? 'active' : ''

    content_tag(:li, class: css) do
      link_to text, path
    end
  end

end