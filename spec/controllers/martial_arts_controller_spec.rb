# encoding: UTF-8
require 'spec_helper'

describe MartialArtsController do

  
  describe "POST create" do
    describe "com parâmetros válidos" do

      let(:martial_art) {
        FactoryGirl.build :martial_art
      }

      it "criar uma nova MartialArt" do
        martial_art.stub(:id).and_return("1")
        params = martial_art.attributes.slice("name", "description")
        MartialArt.should_receive(:create).once.with(params).and_return(martial_art)
        post :create, :martial_art => params
        
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested martial_art" do
        martial_art = FactoryGirl.create(:martial_art)
        MartialArt.any_instance.should_receive(:update).with({ "name" => "Sandá" })
        put :update, {:id => martial_art.to_param, :martial_art => { "name" => "Sandá" }}
      end

      it "redirects to the martial_art" do
        martial_art = FactoryGirl.create(:martial_art)
        put :update, {:id => martial_art.to_param, :martial_art => { "name" => "Sandá" }}
        response.should redirect_to(martial_art)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested martial_art" do
      martial_art = FactoryGirl.create :martial_art
      expect {
        delete :destroy, {:id => martial_art.to_param}
      }.to change(MartialArt, :count).by(-1)
    end

    it "redirects to the martial_arts list" do
      martial_art = FactoryGirl.create :martial_art
      delete :destroy, {:id => martial_art.to_param}
      response.should redirect_to(martial_arts_url)
    end
  end

end
