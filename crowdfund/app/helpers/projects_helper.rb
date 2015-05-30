module ProjectsHelper
  def time_remaining(project)
    if project.past? || project.blank?
      content_tag(:strong, "All done!")
    else
      distance_of_time_in_words(Time.now, project) + " remaining"
    end
  end
end
