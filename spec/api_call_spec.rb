require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'vcr'
require 'json'
require 
require_relative '../lib/api_call'
require_relative 'vcr_setup.rb'
require_relative 'einstein_extract_full_text_json.rb'

describe ApiCall::Call do
  context 'User requests inital paragraph of wiki article' do
    let(:search) { ApiCall::Call.new('Albert Einstein') }

    describe '.initialize' do
      it 'sets the title variable' do
        expect(search.title).to eq('Albert Einstein')
      end
    end

    describe '#form_string' do
      it 'forms url string with correct parameters' do
        expect(search.form_string).to eq('http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&titles=Albert%20Einstein')
      end
    end

    describe '#call_api' do
      it 'uses RestClient to make API call' do
        expect(search.call_api).to eq(  )
      end
    end
  end
end