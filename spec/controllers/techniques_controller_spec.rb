# encoding: UTF-8
require 'spec_helper'

describe TechniquesController do

  describe "GET #search" do

    it "Busca por técnica" do
      @query = "Anaconda"
      @technique = mock_model(Technique)
      Technique.should_receive(:search).with(@query).once
      get :search, query: @query
    end

  end

end