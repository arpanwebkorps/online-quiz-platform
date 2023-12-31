class Api::V1::UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]

#======================================================================
        # GET /api/v1/users
#======================================================================

  def index
    @users = User.all
    render json: @users
  end

#======================================================================
        # GET /api/v1/users/:user_id
#======================================================================

  def show
    render json: @user
  end

#======================================================================
        # POST /api/v1/users/
#======================================================================

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

#======================================================================
        # PATCH/PUT /api/v1/users/1
#======================================================================

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

#======================================================================
        # DELETE /api/v1/users/1
#======================================================================

  def destroy
    if @user.destroy
      render json: { data: "user destroyed successfully" }
    else
      render json: { error: "Failed to destroy user" }
    end
  end

  private

  def set_user
    # @user = User.find(params[:id])
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def user_params
    # byebug
    params.require(:user).permit(:email, :password, :role)
  end
end
