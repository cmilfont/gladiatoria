class TechniquesController < ApplicationController

  respond_to :html, :json

  def search
    @techniques = Technique.search params[:query]
    respond_with @techniques
  end

end
