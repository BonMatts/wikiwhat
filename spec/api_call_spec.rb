require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'json'
require 'rest_client'
require 'vcr'
require 'spec_helper'

require_relative '../lib/wikiwhat/api_call'
require_relative 'testfiles/api_test_einstein'

describe Api::Call do  
  let(:extract) { Api::Call.new('Kel Mitchell', prop:'extracts') }
  let(:revision) {Api::Call.new('Kel Mitchell', prop:'revisions', rvprop:true)}
  let(:images){Api::Call.new('Kel Mitchell', img_list:true)}
  let(:img_url){Api::Call.new('',iiprop:true)}

  describe '.initialize' do
    context 'extracts call'
      it 'sets the title variable, and sets prop to extracts' do
      expect(extract.title).to eq('Kel%20Mitchell')
      expect(extract.prop).to eq('extracts')
    end

    context "revisions call"
      it 'sets the title, prop and rvprop variables' do 

        expect


  end

  describe '#form_string' do
    it 'forms url string with correct parameters' do
      expect(extract.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&prop=extracts&titles=Kel%20Mitchell&format=json&redirects')
    end
  end

  describe '#call_api' do
    it 'uses RestClient to make API call' do
      VCR.use_cassette('kel_extract') do
        api_output = extract.call_api

        expect(api_output).to be_a(Hash)
        expect(api_output).to eq(testoutput)
      end
    end
  end
end