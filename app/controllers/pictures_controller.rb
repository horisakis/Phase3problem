class PicturesController < ApplicationController
  before_action :set_picture, only: %i[show edit update destroy]
  before_action -> { redirect_to_log_in(params[:user_id]) }, except: :index

  # GET /pictures
  # GET /pictures.json
  def index
    @user = User.find(params[:user_id])
    @pictures = Picture.where(user_id: params[:user_id])
    @favorites = logged_in? ? current_user.favorites : nil
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show; end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
      @picture.image.retrieve_from_cache! params[:image_cache] if params[:image_cache].present?
    else
      @picture = Picture.new

    end
  end

  # GET /pictures/1/edit
  def edit; end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id

    respond_to do |format|
      if @picture.save
        PictureMailer.send_new_picture(@picture).deliver
        format.html { redirect_to user_pictures_path, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to user_pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render 'new' if @picture.invalid?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:image, :message, :user_id, :image_cache)
  end
end
