module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        render json: @model.all
      end

      def create
        doc = @model.new(model_params)

        if doc.save
          render json: doc, status: :created
        else
          render json: doc.errors, status: :unprocessable_entity
        end
      end

      def destroy
        doc = @model.find(params[:id])
        doc.destroy!
        head :no_content
      end
    end
  end
end
