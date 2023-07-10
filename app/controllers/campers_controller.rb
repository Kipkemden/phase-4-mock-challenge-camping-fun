class CampersController < ApplicationController
  before_action :set_camper, only: [:show]

  def index
    campers = Camper.all
    render json: campers, only: [:id, :name, :age]
  end

  def show
    if @camper
      render json: @camper, include: { activities: { only: [:id, :name, :difficulty] } }
    else
      render json: { error: "Camper not found" }, status: :not_found
    end
  end

  def create
    camper = Camper.new(camper_params)

    if camper.save
      render json: camper, status: :created
    else
      render json: { errors: camper.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_camper
    @camper = Camper.find_by(id: params[:id])
  end

  def camper_params
    params.require(:camper).permit(:name, :age)
  end
end
