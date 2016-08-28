class AnalyserController < ApplicationController
  before_filter :authenticate_user!

  def analyse
    service = Services::Analyser.new.(params[:dataset])
    if service.perform
      render json: service.result
    else
      render json: { errors: ['Invalid data'] }, status: 422
    end
  end

  def correlation
    service = Services::CorrelationChecker.new(params[:first_dataset], params[:second_dataset])

    if service.perform
      render json: { correlation: service.result }
    else
      render json: { errors: ['Invalid data'] }, status: 422
    end
  end
end
