class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
  end

  def edit
  end


  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      message,status = "Comment Added" , 200
    else
      message,status = @comment.errors.messages.inspect , 422
    end
    render json:{:message => message} , status: status
  end

  def update
    if comment_update_params[:user_id] == @comment.user_id
      if @comment.update_attributes(comment_update_params)
        message,status = "Updates Successfully" , 200
      else
        message,status = @comment.errors.messages.inspect,422
      end
    else
      message,status = "Unauthorised" , 400
    end
    render json:{:message => message} , status: status
  end


  def destroy
    if comment_params[:user_id] = @comment.user_id
      comment_destroyed = @comment.destroy
      if comment_destroyed.destroyed?
        message,status = "Successfully Destroyed" , 200
      else
        message,status = comment_destroyed.errors.messages.inspect,422
      end
    else
      message,status = "Unauthorised" , 400
    end
    render json:{:message => message} , status: status
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end
    def comment_update_params
      params.permit(:comment , :user_id)
    end
    def comment_params
      params.permit(:entity_id, :entity_type, :comment, :user_id)
    end
end
