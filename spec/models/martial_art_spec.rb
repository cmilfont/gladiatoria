require 'spec_helper'

describe MartialArt do
	
	describe "Validações" do
		it { should validate_presence_of :name }
		it { should validate_presence_of :description }
	end
end