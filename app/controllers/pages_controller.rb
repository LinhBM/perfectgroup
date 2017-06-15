class PagesController < ApplicationController
  before_action :load_user, only: :show

  def show
    if valid_page?
      render "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root +
      "app/views/pages/#{params[:page]}.html.erb"))
  end

  def load_user
    @users = User.only_sale_man
  end
end
