# encoding: UTF-8
require 'spec_helper'

describe TechniquesController do

	before :each do 
		Technique.destroy_index
		Technique.create_index
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
        FactoryGirl.build :technique
      }
      it "criar uma nova Technique" do
        technique.stub(:id).and_return("1")
        params = technique.attributes.slice("name", "description")
        Technique.should_receive(:create).once.with(params).and_return(technique)
        post :create, :technique => params
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested technique" do
        technique = FactoryGirl.create(:technique)
        Technique.any_instance.should_receive(:update).with({ "name" => "Anaconda Choke" })
        put :update, {:id => technique.to_param, :technique => { "name" => "Anaconda Choke" }}
      end

      it "redirects to the technique" do
        technique = FactoryGirl.create(:technique)
        put :update, {:id => technique.to_param, :technique => { "name" => "Anaconda Choke" }}
        response.should redirect_to(technique)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested technique" do
      technique = FactoryGirl.create :technique
      expect {
        delete :destroy, {:id => technique.to_param}
      }.to change(Technique, :count).by(-1)
    end

    it "redirects to the techniques list" do
      technique = FactoryGirl.create :technique
      delete :destroy, {:id => technique.to_param}
      response.should redirect_to(techniques_url)
    end

  end

end