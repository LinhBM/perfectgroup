class Users::SessionsController < Devise::SessionsController
  def create
    @user = User.find_by email: params[:user][:email]
    if @user.present? && @user.role == "locked"
      flash[:error] = t "user_locked"
      redirect_to root_path
    elsif @user.present?
      super
    end
  end
end
