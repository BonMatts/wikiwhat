require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'json'
require 'rest_client'

require_relative '../lib/api_call'
require_relative 'testfiles/api_test_einstein'

describe ApiCall::Call do
  context 'User requests inital paragraph of wiki article' do
    let(:search) { ApiCall::Call.new('Albert Einstein') }

    describe '.initialize' do
      context 'User does not specify prop or query'
        it 'sets the title variable, uses default prop and action values' do
        
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
        expect(search.call_api).to eq(testoutput)
      end
    end
  end
end