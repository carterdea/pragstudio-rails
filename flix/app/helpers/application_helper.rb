module ApplicationHelper
  def title
    if content_for?(:title)
      content_tag(:title, "#{content_for(:title)} | Flix")
    else
      content_tag(:title, "Flix")
    end
  end

end
