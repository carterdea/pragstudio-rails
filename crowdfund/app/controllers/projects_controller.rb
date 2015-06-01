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
    @project.update(cleaned_params)
    redirect_to @project
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(cleaned_params)
    @project.save
    redirect_to @project
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

private
  def cleaned_params
    params.require(:project).permit(:name, :description, :website, :team_members, :image_file_name, :target_pledge_amount, :pledging_ends_on)
  end
end
