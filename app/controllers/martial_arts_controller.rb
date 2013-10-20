class MartialArtsController < ApplicationController

  respond_to :html

  before_action :set_martial_art, only: [:show, :edit, :update, :destroy]

  def index
    @martial_arts = MartialArt.all
  end

  def show
  end

  def new
    @martial_art = MartialArt.new
  end

  def edit
  end

  def create
    @martial_art = MartialArt.create martial_art_params
    respond_with @martial_art
  end

  def update
    @martial_art.update(martial_art_params)
    respond_with @martial_art

  end

  # DELETE /martial_arts/1
  # DELETE /martial_arts/1.json
  def destroy
    @martial_art.destroy
    respond_to do |format|
      format.html { redirect_to martial_arts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_martial_art
      @martial_art = MartialArt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def martial_art_params
      params.require(:martial_art).permit(:name, :description)
    end
end
