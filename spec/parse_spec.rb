require 'rubygems'
require 'bundler/setup'
require_relative '../lib/parse'
require_relative 'testfiles/api_test_einstein'

describe Parse::Text do
  context 'User requests inital paragraph of wiki article' do
    let(:text){Parse::Text.new}
    describe ".pull_from_hash" do
      it 'returns the relevant content from the hash' do
        expect(text.pull_from_hash(testoutput2, "extract")).to eq(content)

      end
    end

    describe "#paragraph" do
      it "returns the first paragraph" do
        expect(text.paragraph(content)).to eq("<b>Cottage Lake</b> is a census-designated place (CDP) in King County, Washington, United States. The population was 22,494 at the 2010 census. The lake itself falls within the 98072 zip code, while the developments east of the lake fall under the 98077 zip code.")
      end
    end
  end
end