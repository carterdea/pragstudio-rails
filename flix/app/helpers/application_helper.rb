module ApplicationHelper
  def title
    if content_for?(:title)
      content_tag(:title, "#{content_for(:title)} | Flix")
    else
      content_tag(:title, "Flix")
    end
  end

  def nav_link_to(text, url)
    classes = []
    classes << 'active' if current_page?(url)
    link_to(text, url, class: classes.join(' '))
  end

end
