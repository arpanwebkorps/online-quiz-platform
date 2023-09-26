class Api::V1::CodingQuestionsController < ApplicationController

  def index
    @coding_question = CodingQuestion.all
    render json: @coding_question
  end
end
