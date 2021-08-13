class UsersController < RailsJwtAuth::ProfilesController
  before_action :set_user, only: [:show, :update, :destroy]
  # before_action :authenticate_user!
  before_action :is_user?

  # GET /users/1
  def show
    render json: {user: @user}
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:email, :password, :first_name, :last_name)
    end

    def is_user?
      if current_user.nil? || @user.id != current_user.id
        render json: { message: current_user }, status: :unauthorized
      end
    end
end
