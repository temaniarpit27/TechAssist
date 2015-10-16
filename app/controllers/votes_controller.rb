class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  # GET /votes
  # GET /votes.json
  def index
    @votes = vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
  end

  def edit
  end
    
 
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      message,status = "vote Added" , 200
    else
      message,status = @vote.errors.messages.inspect , 422
    end
    render json:{:message => message} , status: status
  end

  def update
    if vote_update_params[:user_id] == @vote.user_id
      if @vote.update_attributes(vote_update_params)
        message,status = "Updates Successfully" , 200
      else
        message,status = @vote.errors.messages.inspect,422
      end
    else
      message,status = "Unauthorised" , 400
    end
    render json:{:message => message} , status: status
  end


  def destroy
    if vote_params[:user_id] = @vote.user_id
      vote_destroyed = @vote.destroy
      if vote_destroyed.destroyed?
        message,status = "Successfully Destroyed" , 200
      else
        message,status = vote_destroyed.errors.messages.inspect,422
      end
    else
      message,status = "Unauthorised" , 400
    end
    render json:{:message => message} , status: status
  end

  private
    def set_vote
      @vote = vote.find(params[:id])
    end
    def vote_update_params
      params.permit(:vote , :user_id)
    end
    def vote_params
      params.permit(:entity_id, :entity_type, :vote_flag, :user_id)
    end
end
