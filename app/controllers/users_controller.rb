class UsersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :finish_signup
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]

 # GET/PATCH /users/:id/finish_signup
 def finish_signup
    logger.info(@user==current_user)
    authorize! :update, @user 
    if request.patch? && user_params
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        #redirect_to @user, notice: 'Your profile was successfully updated.'
        flash[:info]=t('devise.failure.unconfirmed')+" "+t('devise.confirmations.send_instructions');
        respond_to do |format|
          format.html;
          format.js{render js:'location.reload()'}
        end
      else
        logger.info @user.errors;
        @show_errors = true
        respond_to do |format|
          format.html;
          format.js{render 'finish_signup'}
        end
      end
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
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

  # POST /users
  # POST /users.json
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if(user_params[:password].present?)
        @user.update_attributes(user_params)
      else
        @user.update_without_password(user_params)
      end

      if @user.errors.empty?
        flash[:success]='User was successfully updated.';
        format.js {render js:'location.reload()'}
        format.json { render :show, status: :ok, location: @user }
      else
        format.js { render 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if(@user.destroy)
      redirect_to :back, error: 'Error!'
    else
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def needs_password?(user, user_params)
      !user_params[:password].blank?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
