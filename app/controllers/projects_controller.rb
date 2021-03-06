class ProjectsController < ApplicationController
  before_action :redirect_signin

  def index
    @project = Project.new
    projects_ids = UserProject.where(user_id: current_user.id).pluck(:project_id)
    @projects = Project.where(id: projects_ids)
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      UserProject.create!(user_id: current_user.id, project_id: @project.id)
      flash[:success] = "プロジェクトの作成に成功しました。"
      redirect_to project_path(@project)
    else
      flash[:danger] = "プロジェクトの作成に失敗しました。"
      redirect_to projects_path
    end
  end

  def show
    @project = Project.find(params[:id])
    @not_have_user_emails = User.where.not(id: @project.user_ids).map(&:email)
  end

  private
  def project_params
    params.require(:project).permit(:title)
  end
end
