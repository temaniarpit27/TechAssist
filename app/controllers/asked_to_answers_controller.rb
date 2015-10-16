class AskedToAnswersController < ApplicationController
  before_action :set_asked_to_answer, only: [:show, :edit, :update, :destroy]

  # GET /asked_to_answers
  # GET /asked_to_answers.json
  def index
    @asked_to_answers = AskedToAnswer.all
  end

  # GET /asked_to_answers/1
  # GET /asked_to_answers/1.json
  def show
  end

  # GET /asked_to_answers/new
  def new
    @asked_to_answer = AskedToAnswer.new
  end

  # GET /asked_to_answers/1/edit
  def edit
  end

  # POST /asked_to_answers
  # POST /asked_to_answers.json
  def create
    @asked_to_answer = AskedToAnswer.new(asked_to_answer_params)

    respond_to do |format|
      if @asked_to_answer.save
        format.html { redirect_to @asked_to_answer, notice: 'Asked to answer was successfully created.' }
        format.json { render :show, status: :created, location: @asked_to_answer }
      else
        format.html { render :new }
        format.json { render json: @asked_to_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asked_to_answers/1
  # PATCH/PUT /asked_to_answers/1.json
  def update
    respond_to do |format|
      if @asked_to_answer.update(asked_to_answer_params)
        format.html { redirect_to @asked_to_answer, notice: 'Asked to answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @asked_to_answer }
      else
        format.html { render :edit }
        format.json { render json: @asked_to_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asked_to_answers/1
  # DELETE /asked_to_answers/1.json
  def destroy
    @asked_to_answer.destroy
    respond_to do |format|
      format.html { redirect_to asked_to_answers_url, notice: 'Asked to answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asked_to_answer
      @asked_to_answer = AskedToAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asked_to_answer_params
      params.require(:asked_to_answer).permit(:question_id, :user_id)
    end
end
