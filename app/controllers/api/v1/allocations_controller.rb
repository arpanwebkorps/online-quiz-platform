class Api::V1::AllocationsController < ApplicationController
  # before_action :authenticate_admin!
  before_action :find_id, only: [:show,:destroy]


#====================================================
        # GET /api/v1/allocations
#====================================================

  def index
    @allocations = Allocation.all
    render json: @allocations
  end

  def show
    render json: @allocation
  end

  def create
    @allocation = Allocation.new(allocation_params)
  rescue ArgumentError => e
    render json: {error: e.message}
    if @allocation.save
      render json: @allocation
    else
      render json: {error: @allocation.errors.full_messages}
    end
  end

  def destroy
  if @allocation.destroy
    render json: @allocation
  else
    render json: {error: @allocation.errors.full_messages}
  end  end


  def take
    assessment = Assessment.find(params[:assessment_id])
    render json: take_assessment(assessment)
  end

  def submit
    @assessment = Assessment.find(params[:assessment_id]).questions
    render json: submit_assessment(@assessment)
  end


  private

  def submit_assessment(assessment)
    score = 0
    option_select = params[:answers]
    assessment.each_with_index do |question, i|
      correct_option = question.answers.find_by(correct: true)&.content
      if correct_option == option_select[i]
        score += 1
      end
    end
    Allocation.where(assessment_id: params[:assessment_id]).update(score: score)
  end

  def take_coding_assessment
    byebug
    code = params[:code]
    language = params[:language]

    jdoodle_service = JDoodleService.new(
      JDoodleAPI::CLIENT_ID,
      JDoodleAPI::CLIENT_SECRET
    )

    response = jdoodle_service.compile_and_execute(code, language)

    # Store the results in the Submission model
    # submission = Submission.create(
    #   user: current_user,
    #   coding_problem_id: params[:coding_problem_id],
    #   code: code,
    #   output: response['stdout'],
    #   # Additional fields as needed (e.g., score, status)
    # )

    # Respond with the submission details
    render json: submission
  end
  def take_assessment(assessment)
    data = {}
    questions = assessment.questions
    data["assessment"] = {
      assessment_id:  assessment.id,
      title:  assessment.title,
      total_mcqs_questions: assessment.total_mcqs_questions,

      questions:questions.map do |question|
        {
        question: question.content,
        answers: question.answers.map do |answer|
          { option: answer.content }
        end
        }
      end
    }
  end

  def find_id
    @allocation = Allocation.find(params[:id])
  end

  def allocation_params
    params.require(:allocation).permit(:user_id, :assessment_id)
  end
end
