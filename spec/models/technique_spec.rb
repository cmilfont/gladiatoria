require 'spec_helper'

describe Technique do

  describe "Mapeamento" do
    it { should be_mapped_by :title }
    it { should be_mapped_by(:title).with_boost(10) }
  end

  describe "Validações" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end

  describe ".search" do

    before do
      @elasticsearch_object = '{"took": 1,"timed_out": false,"_shards": {"total": 5,"successful": 5,"failed": 0},"hits": {"total": 0,"max_score": null,"hits": []}}'
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:any, %r|\Ahttp://localhost:9200|, :body => @elasticsearch_object)
    end

    it "Deveria trazer apenas o indexado com a busca" do
      @technique = Technique.new title: "Ura juji jime", description: "Ura-Juji-Jime", id: 2
      Technique.stub(:find).and_return [@technique]
      @results = [@technique]
      expect(Technique.search("Ura")).to eq(@results)
    end

    it "Retorna vazio se não passar parâmetro" do
      expect(Technique.search).to be_empty
    end

    it "Retorna vazio se passar nil" do
      expect(Technique.search(nil)).to be_empty
    end

  end

end