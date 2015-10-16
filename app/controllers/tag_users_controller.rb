class TagUsersController < ApplicationController
  before_action :set_tag_user, only: [:show, :edit, :update, :destroy]

  # GET /tag_users
  # GET /tag_users.json
  def index
    @tag_users = TagUser.all
  end

  # GET /tag_users/1
  # GET /tag_users/1.json
  def show
  end

  # GET /tag_users/new
  def new
    @tag_user = TagUser.new
  end

  # GET /tag_users/1/edit
  def edit
  end

  # POST /tag_users
  # POST /tag_users.json
  def create
    @tag_user = TagUser.new(tag_user_params)

    respond_to do |format|
      if @tag_user.save
        format.html { redirect_to @tag_user, notice: 'Tag user was successfully created.' }
        format.json { render :show, status: :created, location: @tag_user }
      else
        format.html { render :new }
        format.json { render json: @tag_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_users/1
  # PATCH/PUT /tag_users/1.json
  def update
    respond_to do |format|
      if @tag_user.update(tag_user_params)
        format.html { redirect_to @tag_user, notice: 'Tag user was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag_user }
      else
        format.html { render :edit }
        format.json { render json: @tag_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_users/1
  # DELETE /tag_users/1.json
  def destroy
    @tag_user.destroy
    respond_to do |format|
      format.html { redirect_to tag_users_url, notice: 'Tag user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_user
      @tag_user = TagUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_user_params
      params.require(:tag_user).permit(:user_id, :question_id)
    end
end
