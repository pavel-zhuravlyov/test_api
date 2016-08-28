class AnalyserController < ApplicationController
  before_filter :authenticate_user!

  def analyse
    result = Analyser.new.analyse(params[:dataset])
    if result
      render json: result
    else
      render json: { :errors => ['Invalid data'] }, :status => 422
    end
  end

  def correlation
    result = Analyser.new.correlation(params[:first_dataset], params[:second_dataset])
    if result
      render json: { correlation: result }
    else
      render json: { errors: ['Invalid data'] }, status: 422
    end
  end
end
