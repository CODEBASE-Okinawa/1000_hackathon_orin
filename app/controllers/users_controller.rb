class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if logged_in? && current_user == @user
      @user = User.find(params[:id])
    else
      redirect_to current_user
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '更新しました。'
      redirect_to @user
    else
      flash[:danger] = '更新に失敗しました。'
      redirect_to edit_user_path
    end
  end

  def update_from_project
    user = User.find_by_email(params[:email])
    user_project = UserProject.find(user.id)
    if user_project
      user_project.update(project_id: params[:id])

      flash[:success] = "ユーザーの更新に成功しました。"
      redirect_to project_path(params[:id])
    else
      flash[:danger] = "ユーザーの更新に失敗しました。"
      redirect_to project_path(params[:id])
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
