require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'json'
require 'rest_client'
require 'vcr'
require 'spec_helper'

require_relative '../lib/wikiwhat/api_call'
require_relative 'testfiles/api_call_contents'

describe Api::Call do  
  let(:extract) { Api::Call.new('Kel Mitchell', prop:'extracts') }
  let(:revision) {Api::Call.new('Kel Mitchell', prop:'revisions', rvprop:true)}
  let(:images){Api::Call.new('Kel Mitchell', img_list:true)}
  let(:img_url){Api::Call.new('',iiprop:true)}

  describe '.initialize' do
    context 'extracts call' do
      it 'sets the title variable, and sets prop to extracts' do
        expect(extract.title).to eq('Kel%20Mitchell')
        expect(extract.prop).to eq('&prop=extracts')
      end
    end

    context "revisions call" do
      it 'sets the title, prop and rvprop variables' do 

        expect(revision.prop).to eq('&prop=revisions')
        expect(revision.rvprop).to eq('&rvprop=content')

      end
    end
  end

  describe '#form_string' do
    it 'forms url string with correct parameters' do
      
      expect(extract.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&prop=extracts&titles=Kel%20Mitchell&format=json&redirects')
      expect(revision.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&prop=revisions&titles=Kel%20Mitchell&format=json&redirects&rvprop=content')
    end
  end

  describe '#call_api' do
    context 'extract call' do
      it 'uses RestClient to make API call' do   
        VCR.use_cassette('kel_extract') do
          api_output = extract.call_api

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(ext_testoutput)
        end
      end
    end

    context 'revisions call' do
      it 'uses RestClient to make API call' do
        VCR.use_cassette('kel_revisions') do
          api_output = revision.call_api 

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(rev_testoutput)
        end
      end
    end
  end
end