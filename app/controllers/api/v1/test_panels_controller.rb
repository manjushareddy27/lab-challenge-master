module Api
  module V1
    class TestPanelsController < ApplicationController
      class InvalidParam < StandardError; end
      class Unauthorised < StandardError; end
      # GET /test_panels
      # cache API response

      def index
        key = { id: params[:id], include: params[:include] }
        raise Unauthorised, 'Unauthorized access.' unless ApiKey.can_access?(params[:api_key])
        raise InvalidParam, 'Invalid Test Panel ID.' if params[:id].blank?

        result = Rails.cache.fetch(key, expires_in: 30.minutes) do
          TestPanelSearch.new(test_id: params[:id],
                              include: params[:include]).execute
        end
        render json: result, status: :ok
      rescue StandardError => e
        render json: e.message, status: 404
      end
    end
  end
end
