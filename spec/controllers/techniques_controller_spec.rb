# encoding: UTF-8
require 'spec_helper'

describe TechniquesController do

	before :each do 
		#Technique.destroy_index
		#Technique.create_index
	end

  describe "GET #search" do
    it "Busca por técnica" do
      @query = "Anaconda"
      @technique = mock_model(Technique)
      Technique.should_receive(:search).with(@query).once
      get :search, query: @query
    end
  end

  describe "GET #index" do
    it "chama o metodo all" do
      Technique.should_receive(:all).once
      get :index
    end
  end

  describe "GET #show" do
    it "chama o metodo find" do
      technique = mock_model(Technique)
      Technique.should_receive(:find).once
      get :show, id: technique
    end
  end

  describe "GET #show" do
    it "chama o metodo new" do
      Technique.should_receive(:new).once
      get :new
    end
  end

  describe "POST create" do
    describe "com parâmetros válidos" do
      let(:technique) {
        FactoryGirl.build :technique, :id => 2
      }
      it "criar uma nova Technique" do
        params = technique.attributes.slice("name", "description")
        Technique.should_receive(:create).once.with(params).and_return(technique)
        post :create, :technique => params
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do

      let(:technique) {
        FactoryGirl.build :technique, :id => 2
      }

      it "updates the requested technique" do
        Technique.should_receive(:find).once.with(technique.id.to_s).and_return technique
        Technique.any_instance.should_receive(:update).once.with({ "name" => "Anaconda Choke" })
        put :update, {:id => technique.id, :technique => { "name" => "Anaconda Choke" }}
      end

    end
  end

  describe "DELETE destroy" do

    let(:technique) {
      FactoryGirl.build :technique, :id => 2
    }

    it "destroys the requested technique" do
      Technique.should_receive(:find).once.with(technique.id.to_s).and_return technique
      Technique.any_instance.should_receive(:destroy).once
      delete :destroy, :id => technique.id
    end
  end

end