module V1
  class AuthController < ApplicationController
    def register
      @user = User.new(user_params.merge(provider: "email"))
      if @user.save
        @token = @user.generate_jwt
        render :register, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def login
      @user = User.find_by(email: params[:email], provider: "email")
      if @user&.authenticate(params[:password])
        @token = @user.generate_jwt
        render :login
      else
        render json: { errors: [ "Invalid email or password" ] }, status: :unauthorized
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :name)
    end
  end
end
