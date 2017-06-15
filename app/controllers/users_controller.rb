class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :destroy, :update]

  def index
    @users = User.unless_admin.all.paginate page: params[:page]
  end

  def show
    @products = @user.products
    if current_user.following? @user
      @following = current_user.active_relationships
        .find_by followed_id: @user.id
    else
      @following = current_user.active_relationships.build
    end
  end

  def update
    if @user.update_attributes(secure_params)
      flash[:success] = t "user_updated"
    else
      flash[:error] = t "unable_update_user"
    end
    redirect_to users_path
  end

  def destroy
    @user.destroy
    flash[:success] = t ".complete"
    redirect_to root_url
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      redirect_to root_url
      flash[:danger] = t ".flash"
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end
end
