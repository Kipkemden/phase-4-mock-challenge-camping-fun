class SignupsController < ApplicationController
  def create
    signup = Signup.new(signup_params)

    if signup.save
      activity = signup.activity
      render json: activity, only: [:id, :name, :difficulty]
    else
      render json: { errors: signup.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def signup_params
    params.require(:signup).permit(:time, :camper_id, :activity_id)
  end
end
