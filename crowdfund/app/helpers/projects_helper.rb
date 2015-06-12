module ProjectsHelper
  def time_remaining(project)
    if project.past? || project.blank?
      content_tag(:strong, "All done!")
    else
      distance_of_time_in_words(Time.now, project) + " remaining"
    end
  end

  def image_for(project)
    if project.image_file_name.blank?
      image_tag('placeholder.jpg')
    else
      image_tag(project.image_file_name)
    end
  end

  def pledge_or_funded(project)
    if project.funded?
      "Funded!"
    else
      link_to "Make a Pledge", new_project_pledge_path(@project)
    end
  end
end
