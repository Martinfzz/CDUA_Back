module RailsJwtAuth
  module ParamsHelper
    private

    def profile_update_params
      params.require(:profile).permit(:first_name, :last_name)
    end

  end
end