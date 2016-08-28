class AnalyserController < ApplicationController
  before_filter :authenticate_user!

  def
    render json: Analyser.new.analyse(params[:dataset])
  end

  def correlation
    render json: { correlation: Analyser.new.correlation(params[:first_dataset], params[:second_dataset]) }
  end
end
