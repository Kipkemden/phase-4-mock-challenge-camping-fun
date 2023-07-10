class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:destroy]

  def index
    activities = Activity.all
    render json: activities, only: [:id, :name, :difficulty]
  end

  def destroy
    if @activity
      @activity.destroy
      render json: {}, status: :no_content
    else
      render json: { error: "Activity not found" }, status: :not_found
    end
  end

  private

  def set_activity
    @activity = Activity.find_by(id: params[:id])
  end
end
