class AnalyserController < ApplicationController
  before_filter :authenticate_user!

  def analyse
    service = Analyser.new({dataset: params[:dataset]})

    if service.perform
      render json: service.result
    else
      render json: { errors: ['Invalid data'] }, status: 422
    end
  end

  def correlation
    service = CorrelationChecker.new({first_dataset: params[:first_dataset], second_dataset: params[:second_dataset]})

    if service.perform
      render json: { correlation: service.result }
    else
      render json: { errors: ['Invalid data'] }, status: 422
    end
  end
end
