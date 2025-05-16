class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :delete, :posts_index ]
  before_action :authenticate_request, only: [ :update, :delete, :create ]
  def index
    users = User.all
    render json: UserBlueprint.render(users, view: :normal), status: 200
  end

  def show
    render json: { payload: @user, status: 200 }
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def delete
    if @user.destroy
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def posts_index
    user_posts = @user.posts
    render json: user_posts, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:username, :email, :first_name, :last_name, :password, :password_confirmation)
  end
end
