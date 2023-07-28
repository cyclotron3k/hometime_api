class Api::V1::ReservationsController < ApplicationController
  def upsert
    params.permit!
    begin
      render json: {success: PayloadParser.create_entities!(params.to_h)}
    rescue => e
      Rails.logger.error "#{e.class}: #{e.message}"
      render json: {success: false}, status: :bad_request
    end
  end
end
