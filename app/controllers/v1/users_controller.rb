module V1
  class UsersController < ApplicationController
    before_action :authenticate_user!

    def profile
      @user = current_user
      if @user.update(user_params)
        render :profile
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email)
    end
  end
end
