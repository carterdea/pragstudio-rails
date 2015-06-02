class ProjectsController < ApplicationController
  def index
    @projects = Project.accepting_pledges
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(cleaned_params)
      redirect_to @project, notice: "Successfully updated the project."
    else
      render :edit
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(cleaned_params)
    if @project.save
      redirect_to @project, notice: "Successfully created the project."
    else
      render :new
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, alert: "Successfully deleted the project."
  end

private
  def cleaned_params
    params.require(:project).permit(:name, :description, :website, :team_members, :image_file_name, :target_pledge_amount, :pledging_ends_on)
  end
end
