class ProfileController < RailsJwtAuth::ProfilesController
  before_action :authenticate!

  def show
    render json: {user: current_user}
  end

  def update
    if current_user.update(user_params)
      render json: {user: current_user}
    else
      render json: {error: current_user}, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:email, :password, :first_name, :last_name)
    end
end
