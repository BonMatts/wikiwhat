require 'rubygems'
require 'bundler/setup'
require_relative '../lib/wikiwhat/parse'
require_relative '../lib/wikiwhat/api_call'
require_relative 'testfiles/api_call_contents'
include Parse

describe Parse::Results do
  let(:result){Parse::Results.new()}
  describe "#pull_from_hash" do
    it "looks for a key in a nested hash and returns the value" do

      expect(result.pull_from_hash(ext_output, "extract")).to eq(ext_content)
    end
  end
end

describe Parse::Text do
  let(:kel){Parse::Text.new(ext_output)}
  let(:kel_rev){Parse::Text.new(rev_output, "revisions")}

  describe "#paragraph" do
    it"returns a number of paragraphs based on user input"do

      expect(kel.paragraph(9999)).to eq(ext_all_paras)
      expect(kel.paragraph(2)).to eq(ext_all_paras[0..1])
    end
  end

  describe '#find header' do
    it "returns paragraphs under a specific header" do
     
      expect(kel.find_header("Personal")).to eq((ext_all_paras[5].split("</h2>")[1]+"\n"))
    end
  end

  describe '#sidebar_image' do
    it "returns the URL of the sidebar image, if any" do
      Api::Call.stub(:call_api).and_return(img_url_output)
      expect(kel_rev.sidebar_image).to eq(img_url_content)
    end
  end

  describe '#refs' do
    it "returns an array of references in the wikipedia page" do

      expect(kel_rev.refs).to eq(refs_content)
    end
  end
end

describe Parse::Media do
  let(:albert){Parse::Media.new(img_output, "pages")}

  describe '#list_images' do
    it "pulls out file names and queries the api for their urls, returns an array of urls" do
      Api::Call.stub(:call_api).and_return(media_list_1, media_list_2, media_list_3, media_list_4, media_list_5, media_list_6, media_list_7, media_list_8, media_list_9, media_list_10)

      expect(albert.list_images).to eq(list_images_output)

    end
  end  
end

