class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      message,status = "Answer Added" , 200
    else
      message,status = @answer.errors.messages.inspect , 422
    end
    render json:{:message => message} , status: status
  end

  def update
    if answer_params[:user_id] == @answer.user_id
      if @answer.update_attributes(answer_params)
        message,status = "Updated Successfully" , 200
      else
        message,status = @answer.errors.messages.inspect,422
      end
    else
      message,status = "Unauthorised" , 400
    end
    render json:{:message => message} , status: status
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    if answer_params[:user_id] = @answer.user_id
      answer_destroyed = @answer.destroy
      if answer_destroyed.destroyed?
        message,status = "Successfully Destroyed" , 200
      else
        message,status = answer_destroyed.errors.messages.inspect,422
      end
    else
      message,status = "Unauthorised" , 400
    end
    render json: {:message => message} , status: status
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.permit(:answer, :question_id , :user_id)
    end

end
