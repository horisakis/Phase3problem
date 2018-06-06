class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[show edit update destroy]
  before_action -> {redirect_to_log_in(params[:user_id])}, except: :index

  # GET /favorites
  # GET /favorites.json
  def index
    @favorites = current_user.favorites
  end

  # POST /favorites
  # POST /favorites.json
  def create
    @favorite = current_user.favorites.new(picture_id: params[:picture_id])
    @favorite.user_id = current_user.id

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to params[:back_path], notice: 'Favorite was successfully created.' }
        format.json { render :show, status: :created, location: @favorite }
      else
        format.html { render params[:back_path] }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    @favorite = current_user.favorites.new(favorite_params)

    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to params[:back_path], notice: 'Favorite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def favorite_params
    params.require(:favorite).permit(:picture_id)
  end
end
