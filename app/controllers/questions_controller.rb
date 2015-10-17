class QuestionsController < ApplicationController
  include VotesHelper
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
    render json: {:questions => @questions} , status: 200
  end

  # GET /questions/1
  # GET /questions/1.jso
  def show
    @question =  Question.find(params[:id])
    @answers =  @question.answers
    @comments =  @question.comments
    @votes = get_votes(@question)
    for answer in @answers do
      answer[:comments] = answer.comments
      answer[:votes] = get_votes(answer)
    end

   render json: {:questions => @question, :comments => @comments, :votes => @votes, :answers => @answers} , status: 200
  end

  def show_question
    @question = Question.find(params[:id].to_i)
    render "show_question"
  end

  def post_question
    @repos = Repository.all
    render "post_question"
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    if @question.save
      message,status = "Question Posted Successfully",200
    else
      message,status = @question.errors.messages.inspect,422
    end
    render json: {:message => message} , status: status
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question_user = @question.user_id
    if @question_user == question_params[:user_id]
      if @question.update_attributes(update_question_params)
        message,status = "Updated Successfully",200
      else
        message,status = @question.errors.messages.inspect,422
      end
    else
      message = "Unauthorized",400
    end
    render json:{:message => message } , status: status
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question_user = @question.user_id
    if @question_user == question_params[:user_id]
      destroyed_question = @question.destroy
      if destroyed_question.destroyed?
        message,status ="Question Deleted Successfully",200
      else
        message,status=destroyed_question.errors.messages.inspect,422
      end
    else
      message,status="Unauthorized",400
    end
    render json:{:message => message} , status: status
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def update_question_params
      params.permit(:title, :description , :repository_id )
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.permit(:title, :description , :repository_id , :user_id)
    end
end
