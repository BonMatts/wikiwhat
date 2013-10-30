require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'json'
require 'rest_client'
require 'vcr'
require 'spec_helper'

require_relative '../lib/wikiwhat/api_call'
require_relative 'testfiles/api_call_contents'

include Api

describe Api::Call do  
  let(:extract) { Api::Call.new('Kel Mitchell', prop:'extracts') }
  let(:revision) {Api::Call.new('Kel Mitchell', prop:'revisions', rvprop:true)}
  let(:images){Api::Call.new('Albert Einstien', img_list:true)}
  let(:img_url){Api::Call.new("File:Albert Einstein's exam of maturity grades (color2).jpg", prop:"imageinfo", iiprop:true)}


  describe '#form_string' do
    it 'forms url string with correct parameters' do
      
      expect(extract.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&prop=extracts&titles=Kel%20Mitchell&format=json&redirects')
      
      expect(revision.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&prop=revisions&titles=Kel%20Mitchell&format=json&redirects&rvprop=content')

      expect(images.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&titles=Albert%20Einstien&format=json&redirects&generator=images')

      expect(img_url.form_string).to eq("http://en.wikipedia.org/w/api.php?action=query&prop=imageinfo&titles=File:Albert%20Einstein's%20exam%20of%20maturity%20grades%20(color2).jpg&format=json&redirects&iiprop=url")
    end

  end

  describe '#call_api' do
    context 'extract call' do
      it 'uses RestClient to make API call' do   
        VCR.use_cassette('kel_extract') do
          api_output = extract.call_api

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(ext_output)
        end
      end
    end

    context 'revisions call' do
      it 'uses RestClient to make API call' do
        VCR.use_cassette('kel_revisions') do
          api_output = revision.call_api 

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(rev_output)
        end
      end
    end

    context 'image list call' do
      it "uses RestClient to make API call"  do
        VCR.use_cassette('albert') do
          api_output = images.call_api

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(img_output)
        end
      end
    end

    context 'image url call ' do
      it "uses RestClient to make API call"  do
        VCR.use_cassette('image_url') do
          api_output = img_url.call_api

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(img_url_output)
        end
      end
    end
  end
end