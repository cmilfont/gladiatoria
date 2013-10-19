require 'spec_helper'

describe Technique do

  describe "Validações" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end

  describe ".search" do

  end

end