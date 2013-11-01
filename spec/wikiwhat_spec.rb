require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'json'
require 'rest_client'

require_relative '../lib/wikiwhat'
require_relative '../lib/wikiwhat/api_call'

include Api

describe Wikiwhat::Page do
  describe '.initialize' do
    let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
    let(:hawk) { Wikiwhat::Page.new("Cathartes aura")}

    it 'makes a new Wikiwhat::Page object' do
      expect(pigeon).to be_an_instance_of(Wikiwhat::Page)
      expect(pigeon.title).to eq("Columba livia")
      expect(hawk.class).to eq(Wikiwhat::Page)
    end
  end

  describe "#run" do
    let(:pigeon)      { Wikiwhat::Page.new("Columba livia", :header => "Description") }
    let(:starling)    { Wikiwhat::Page.new("Sturnus vulgaris", paragraphs: 2) }
    let(:mockingbird) { Wikiwhat::Page.new("Mimus polyglottos", img_list: true) }
    let(:dove)        { Wikiwhat::Page.new("Zenaida asiatica", refs: true) }
    let(:grackle)     { Wikiwhat::Page.new("Quiscalus mexicanus", sidebar_img: true) }

    it "sets instance varaibles given the options arguments" do
      expect(pigeon.head).to eq("Description")
      expect(starling.paras).to eq(2)
      expect(mockingbird.img_list).to eq(true)
      expect(dove.refs).to eq(true)
      expect(grackle.sidebar_img).to eq(true)
    end

    it "runs requested method" do
      pending
    end
  end

  describe "#find_paragraphs" do
    context 'When #find_paragraphs is called on a Wikiwhat::Page object' do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      let(:hawk) { Wikiwhat::Page.new("Cathartes aura")}

      it 'makes the call and returns the first paragraph' do
        expect(pigeon.paragraphs).to eq(Array)
        expect(pigeon.paragraphs.length).to eq(1)
      end
    end

    context 'When :paragraphs is set in the options hash' do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia", paragraphs: 2) }

      it 'returns the nubmer of paragraphs requested' do
        expect(pigeon.paragraphs).to be_a(Array)
        expect(pigeon.paragraphs.length).to eq(2)
      end
    end

    context 'When :paragraphs is set in the options hash and is higher than the number availble' do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia", paragraphs: 90) }

      it 'returns the number of paragraphs available' do
        expect(pigeon.paragraphs).to be_a(Array)
        expect(pigeon.paragraphs.length).to eq(23)
      end
    end
  end

  describe "#find_image_list" do
    context 'When #find_image_list is called on a Wikiwhat::Page object' do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia", img_list: true) }

      it "Returns a hash containing a list of urls and image titles" do
        expect(pigeon.image_list.length).to eq(2)
        expect(pigeon.image_list.class).to eq(Hash)
      end
    end
  end

  describe "#find_header" do

  end

  describe "#find_refs" do

  end

  describe "#find_sidebar_image" do

  end
end