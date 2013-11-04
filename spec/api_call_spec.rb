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
  


  # describe '.form_string' do
  #   it 'forms url string with correct parameters' do
      
  #     expect(extract.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&prop=extracts&titles=Kel%20Mitchell&format=json&redirects')
      
  #     expect(revision.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&prop=revisions&titles=Kel%20Mitchell&format=json&redirects&rvprop=content')

  #     expect(images.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&titles=Albert%20Einstien&format=json&redirects&generator=images')

  #     expect(img_url.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&prop=imageinfo&titles=File:Kelmitchellpic.jpg&format=json&redirects&iiprop=url')
  #   end

  # end

  describe '.call_api' do
    context 'extract call' do
      it 'forms the call string & uses RestClient to make API call' do   
        VCR.use_cassette('kel_extract') do

          api_output = Api::Call.call_api('Kel Mitchell', prop:'extracts') 

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(ext_output)
        end
      end
    end

    context 'revisions call' do
      it 'forms the call string & uses RestClient to make API call' do
        VCR.use_cassette('kel_revisions') do
          api_output = Api::Call.call_api('Kel Mitchell', prop:'revisions', rvprop:true)

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(rev_output)
        end
      end
    end

    context 'image list call' do
      it "forms the call string & uses RestClient to make API call"  do
        VCR.use_cassette('albert') do
          api_output = Api::Call.call_api('Albert Einstien', img_list:true)

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(img_output)
        end
      end
    end

    context 'image url call ' do
      it "uses RestClient to make API call"  do
        VCR.use_cassette('image_url') do
          api_output = Api::Call.call_api("File:Kelmitchellpic.jpg", prop:"imageinfo", iiprop:true)

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(img_url_output)
        end
      end
    end
  end
end
