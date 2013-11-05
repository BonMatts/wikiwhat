require 'rspec'

require_relative '../lib/wikiwhat'
require_relative 'testfiles/api_call_contents'

include Api
include Parse
include WikiwhatApp

describe Wikiwhat::Page do
  describe "#find_paragraphs" do
    context "When #find_paragraphs is called on a Wikiwhat::Page object" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        pigeon.find_paragraphs
        expect(Api::Call).to have_received(:call_api)
      end
      it "calls #paragraphs on a Parse::Text instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect_any_instance_of(Parse::Text).to receive(:paragraph).with(1)
        pigeon.find_paragraphs
      end
    end
    context 'When :num_paragraphs is set in the options hash' do
      it "calls Call.api" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        pigeon = Wikiwhat::Page.new("Columba livia", :num_paragraphs => 2)
        expect(Api::Call).to have_received(:call_api)
      end
      it "calls #paragraphs on a Parse::Text instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect_any_instance_of(Parse::Text).to receive(:paragraph).with(2)
        pigeon = Wikiwhat::Page.new("Columba livia", :num_paragraphs => 2)
      end
    end
    context 'When :num_paragraphs is set in the options hash and is higher than
            the number availble' do
      it "calls #paragraphs on a Parse::Text instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect_any_instance_of(Parse::Text).to receive(:paragraph).with(999)
        pigeon = Wikiwhat::Page.new("Columba livia", :num_paragraphs => 999)
      end
    end
  end
  describe "#find_image_list" do
    context "When #find_image_list is called on a Wikiwhat::Page instance" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_image_list, wikiwhat_page_pigeon_img_url)
        pigeon.find_image_list
        expect(Api::Call).to have_received(:call_api).at_least(1).times
      end
      it "calls #list_image on a Parse::Media instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_image_list)
        expect_any_instance_of(Parse::Media).to receive(:list_images)
        pigeon.find_image_list
      end
    end
    context "when img_list => true is specified in the options hash" do
      it "calls Call.api" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_image_list, wikiwhat_page_pigeon_img_url)
        pigeon = Wikiwhat::Page.new("Columba livia", :img_list => true)
        expect(Api::Call).to have_received(:call_api).at_least(1).times
      end
      it "calls #paragraphs on a Parse::Media instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_image_list)
        expect_any_instance_of(Parse::Media).to receive(:list_images)
        pigeon = Wikiwhat::Page.new("Columba livia", :img_list => true)
      end
    end
  end
  describe "#find_header" do
    context "When a header present in the article is specified in the options hash," do
      it "calls Call.api" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        pigeon = Wikiwhat::Page.new("Columba livia", :header => "Description")
        expect(Api::Call).to have_received(:call_api)
      end
      it "calls #find_header on a Parse::Text instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect_any_instance_of(Parse::Text).to receive(:find_header).with("Description")
        pigeon = Wikiwhat::Page.new("Columba livia", :header => "Description")
      end
    end
    context "When #find_header is called on a Wikiwhat::Page instance with an argument," do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        pigeon.find_header("Description")
        expect(Api::Call).to have_received(:call_api)
      end
      it "calls #find_header on a Parse::Text instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect_any_instance_of(Parse::Text).to receive(:find_header).with("Description")
        pigeon = Wikiwhat::Page.new("Columba livia", :header => "Description")
      end
    end
    context "When #find_header with no argument is called on a Wikiwhat::Page instance," do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "Raises an exception" do
        expect { pigeon.find_header }.to raise_error(ArgumentError)
      end
    end
    context "When a header not present in the article is specified in the options hash" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia", :header => "Biography") }
      it "Raises an exception" do
        expect { pigeon.find_header }.to raise_error(WikiwhatError)
      end
    end
  end
  describe "#find_refs" do
    context "When refs => true is specified in the options hash" do
      it "calls Call.api" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions)
        pigeon = Wikiwhat::Page.new("Columba livia", :refs => true)
        expect(Api::Call).to have_received(:call_api)
      end
      it "calls #refs on a Parse::Text instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions)
        expect_any_instance_of(Parse::Text).to receive(:refs)
        pigeon = Wikiwhat::Page.new("Columba livia", :refs => true)
      end
    end
    context "When #find_refs is called on a Wikiwhat::Page instance" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions)
        pigeon.find_refs
        expect(Api::Call).to have_received(:call_api)
      end
      it "calls #refs on a Parse::Text instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions)
        expect_any_instance_of(Parse::Text).to receive(:refs)
        pigeon.find_refs
      end
    end
    context "When the page has no references" do
      it "Does something about having no references" do
        pending
      end
    end
  end
  describe "#find_sidebar_image" do
    context "When sidebar_img => true is specified in the options hash" do
      it "calls Call.api" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_image)
        pigeon = Wikiwhat::Page.new("Columba livia", :sidebar_img => true)
        expect(Api::Call).to have_received(:call_api).at_least(1).times
      end
      it "calls #sidebar_image on a Parse::Text instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_image)
        expect_any_instance_of(Parse::Text).to receive(:sidebar_image)
        pigeon = Wikiwhat::Page.new("Columba livia", :sidebar_img => true)
      end
    end
    context "When #find_sidebar_image is called on a Wikiwhat::Page instance" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_image)
        pigeon.find_sidebar_image
        expect(Api::Call).to have_received(:call_api).at_least(1).times
      end
      it "calls #sidebar_image on a Parse::Text instance" do
        Api::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_image)
        expect_any_instance_of(Parse::Text).to receive(:sidebar_image)
        pigeon.find_sidebar_image
      end
    end
    context "When no sidebar image exists" do
      let(:chad) { Wikiwhat::Page.new("Chad Muska") }
      it "Raises an exception" do
        expect { chad.find_sidebar_image }.to raise_error(WikiwhatError)
      end
    end
  end
end
