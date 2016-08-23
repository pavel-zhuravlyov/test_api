class AnalyserController < ApplicationController
  before_filter :authenticate_user!

  def analyse
    render json: Analyser.new.analyse(params[:dataset])
  end

  def correlation
    render json: Analyser.new.correlation(params[:first_dataset], params[:second_dataset])
  end
end
