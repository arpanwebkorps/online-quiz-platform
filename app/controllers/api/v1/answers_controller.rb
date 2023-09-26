class Api::V1::AnswersController < ApplicationController
  before_action :set_find, only: [:update, :destroy]
  before_action :find_assessment, only: [:index, :create]

#======================================================================================
        # GET /api/v1/assessments/:assessment_id/questions/:question_id/answers
#======================================================================================

 def index
  @answers = @question_id
  render json: @answers
 end

 def show
  render json: @answer
 end

# #======================================================================================
#         # POST /api/v1/assessments/:assessment_id/questions/:question_id/answers/
# #======================================================================================

 def create
  # byebug
  @answer = @question_id.new(answer_params)
  if @answer.save
    render json: @answer
  else
    render json: {error: @answer.errors.full_messages }
  end
 end

#==============================================================================================
        # PATCH /api/v1/assessments/:assessment_id/questions/:question_id/answers/:answer_id
#==============================================================================================

  def update

    if @answer.update(answer_params)
      # byebug
      render json: @answer
    else
      render json: {error: @answer.errors.full_messages }
    end
  end


# #==============================================================================================
#         # DELETE /api/v1/assessments/:assessment_id/questions/:question_id/answers/:answer_id
# #==============================================================================================

  def destroy
    # byebug
    if @answer.destroy
      render json: { data: "answer destroyed successfully" }
    else
      render json: {error: @answer.errors.full_messages }
    end
  end

  private

  def find_assessment
    @question_id = Assessment.find(params[:assessment_id]).questions.find(params[:question_id]).answers
  end

  def set_find
    @answer = Assessment.find(params[:assessment_id]).questions.find(params[:question_id]).answers.find(params[:id])
  end
  def answer_params
    params.require(:answer).permit(:content, :correct, :number_of_options)
  end
end
