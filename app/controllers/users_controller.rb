require 'net/http'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy , :get_user_home_details , :get_repo_home_details]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def home
    @user_id = params[:user_id]
    @repositories = Repository.all
    @question = User.find(@user_id).get_all_home_details({:id => @user_id , :status => "trending"})
  end

  #GET /users/1/settings
  def settings
    @users = User.find(params[:user_id])
    @repos = Repository.all
    @checked_repos = UserRepoJoin.where(:user_id => params[:user_id].to_i).pluck(:repository_id)
    #render 'settings'
    render '_header'
  end

  def update_details
    UserRepoJoin.where(:user_id =>params[:user_id].to_i).destroy_all
    params[:checked_repos].each do |checked_repo|
      UserRepoJoin.create(:user_id => params[:user_id].to_i , :repository_id => checked_repo.to_i)
    end
    render json: {:message => "update successfull"} , status: 200
  end

  def get_home_questions
    @user_id = params[:user_id]
    @question = User.find(@user_id).get_all_home_details({:id => @user_id , :status => params[:status]})
    render :partial => 'question_list'
  end


  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def add_repo
    User.add_repository(params)
  end

  def remove_repo
    User.remove_repository(params)
  end

  def get_user_home_details
    @question = @user.get_all_home_details(params)
    render :partial => 'question_list'
  
  end

  def get_repo_home_details
    @question = @user.repo_related_home_details(params[:repository_id] , params[:status])
    render :partial => 'question_list' 
  end


  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    byebug
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :set_flag)
    end
end
