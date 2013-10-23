class TechniquesController < ApplicationController

  respond_to :html, :json

  before_action :set_technique, only: [:show, :edit, :update, :destroy]

  def index
    @techniques = Technique.all
  end

  def show
  end

  def new
    @technique = Technique.new
  end

  def edit
  end

  def create
    @technique = Technique.create technique_params

    unless @technique.new_record?
      redirect_to @technique, :notice => "Cadastrada com sucesso"
    else
      render :new
    end
  end

  def update
    @technique.update(technique_params)
    respond_with @technique
  end

  def destroy
    @technique.destroy
    redirect_to techniques_url
  end

  def search
    @techniques = Technique.search params[:query]
    respond_with @techniques
  end

  private
    def set_technique
      @technique = Technique.find(params[:id])
    end

    def technique_params
      params.require(:technique).permit(:name, :description, :martial_art_ids => [])
    end

  

end
