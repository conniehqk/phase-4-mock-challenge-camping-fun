class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_entity
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
        campers = Camper.all
        render json: campers
    end

    def show
        camper = find_camper
        render json: camper, serializer: CamperShowSerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private
    def camper_params
        params.permit(:name, :age)
    end
    def find_camper
        Camper.find(params[:id])
    end
    def invalid_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
    def render_not_found
        render json: { error: "Camper not found" }, status: :not_found
    end
end
