require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'json'
require 'rest_client'

require_relative '../lib/wikiwhat'
require_relative '../lib/wikiwhat/api_call'
require_relative 'testfiles/api_call_contents'

include Api
include Parse

describe Wikiwhat::Page do
  describe '.initialize' do
    let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
    let(:hawk) { Wikiwhat::Page.new("Cathartes aura") }

    it 'makes a new Wikiwhat::Page object' do
      expect(pigeon).to be_an_instance_of(Wikiwhat::Page)
      expect(pigeon.title).to eq("Columba livia")
      expect(hawk.class).to eq(Wikiwhat::Page)
    end
  end

  describe "#run" do
    let(:pigeon)      { Wikiwhat::Page.new("Columba livia",
                        :header => "Description") }
    let(:starling)    { Wikiwhat::Page.new("Sturnus vulgaris",
                        num_paragraphs: 2) }
    let(:mockingbird) { Wikiwhat::Page.new("Mimus polyglottos",
                        img_list: true) }
    let(:dove)        { Wikiwhat::Page.new("Zenaida asiatica",
                        refs: true) }
    let(:grackle)     { Wikiwhat::Page.new("Quiscalus mexicanus",
                        sidebar_img: true) }

    it "sets instance varaibles given the options arguments" do
      expect(pigeon.head).to eq("Description")
    end

    # it "runs requested method" do
    #   expect(pigeon).to receive(:find_header)
    #   expect(starling).to receive(:find_paragraphs)
    #   expect(mockingbird).to receive(:find_image_list)
    #   expect(dove).to receive(:find_refs)
    #   expect(grackle).to receive(:find_sidebar_image)
    # end
  end

  describe "#find_paragraphs" do
    context 'When #find_paragraphs is called on a Wikiwhat::Page object' do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }

      it 'makes the call and returns the first paragraph' do
        pigeon.find_paragraphs
        # expect_any_instance_of(Api::Call).to receive(:call_api).and_return(wikiwhat_pigeon_find_paragraphs_api_return)
        # expect_any_instance_of(Parse::Text).to receive(:paragraph).with(1)
        expect(pigeon.paragraphs).to be_a(Array)
        expect(pigeon.paragraphs.length).to eq(1)
      end
    end

    context 'When :num_paragraphs is set in the options hash' do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia", :num_paragraphs => 2) }

      it 'returns the nubmer of paragraphs requested' do
        expect(pigeon.paragraphs).to be_a(Array)
        expect(pigeon.paragraphs.length).to eq(2)
      end
    end

    context 'When :num_paragraphs is set in the options hash and is higher than
            the number availble' do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia", num_paragraphs: 90) }

      it 'returns the number of paragraphs available' do
        expect(pigeon.paragraphs).to be_a(Array)
        expect(pigeon.paragraphs.length).to eq(23)
      end
    end
  end

  describe "#find_image_list" do
    context 'When #find_image_list is called when initializing a Wikiwhat::Page
            object' do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia", img_list: true) }

      it "Returns a hash containing a list of urls and image titles" do
        expect(pigeon.image_list.length).to eq(2)
        expect(pigeon.image_list.class).to eq(Hash)
      end
    end

    context 'When #find_image is called on a Wikiwhat::Page object' do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }

      it "Returns a hash containing a list of urls and image titles" do
        expect(pigeon.find_image_list.length).to eq(2)
        expect(pigeon.find_image_list.class).to eq(Hash)
      end
    end
  end

  describe "#find_header" do
    context "When :header is set when creating a new Wikiwhat object" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia",
                     :header => "Description") }

      it "Returns an array of paragraphs under the requested header" do
        expect(pigeon.head).to eq("Description")
        expect(pigeon.header).to be_a(String)
      end
    end

    # context "When .header is called on a Wikiwhat::Page object" do
    #   let(:pigeon) { Wikiwhat::Page.new("Columba livia") }

    #   it "Returns an array of paragraphs under the requested header" do
    #     pigeon.find_header
    #     # expect(pigeon).to receive(:find_paragraphs).and_return()

    #     expect(pigeon.head).to eq("Description")
    #     expect(pigeon.header).to be_a(String)
    #   end
    # end
  end

  describe "#find_refs" do
    context "When 'refs: true' is set when creating a new Wikiwhat object" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia", :refs => true) }

      # TODO: It correctly returns an array, but not with the correct information.
      it "Returns an array of references" do
        expect(pigeon.ref_list).to be_a(Array)
      end
    end
  end


  describe "#find_sidebar_image" do
    context "When 'sidebar: true' is set when creating a new Wikiwhat object" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia", :sidebar_img => true) }

      it "Returns an image url" do
        expect(pigeon.sidebar_img_url).to be_a(String)
        expect(pigeon.sidebar_img_url).to include "http"
      end
    end
  end
end