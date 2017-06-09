class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    @user = User.find_by email: params[:user][:email]
    if @user.present? && @user.role == "locked"
      flash[:error] = t "user_locked"
      redirect_to root_path
    elsif @user.present?
      #sign_in(params[:user][:email], params[:user][:password])
      super
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
