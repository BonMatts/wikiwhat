require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'spec_helper'

require_relative 'testfiles/api_call_contents'

describe Wikiwhat::Page do
  describe "#paragraphs" do
    context "When #paragraphs is called on a Wikiwhat::Page object" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        pigeon.paragraphs
        expect(Wikiwhat::Call).to have_received(:call_api)
      end
      it "calls #paragraphs on a Wikiwhat::Text instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect_any_instance_of(Wikiwhat::Text).to receive(:paragraph).with(1)
        pigeon.paragraphs
      end
    end
    context 'When :num_paragraphs is set in the options hash' do
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        pigeon = Wikiwhat::Page.new("Columba livia", :num_paragraphs => 2)
        expect(Wikiwhat::Call).to have_received(:call_api)
      end
      it "calls #paragraphs on a Wikiwhat::Text instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect_any_instance_of(Wikiwhat::Text).to receive(:paragraph).with(2)
        pigeon = Wikiwhat::Page.new("Columba livia", :num_paragraphs => 2)
      end
    end
    context 'When :num_paragraphs is set in the options hash and is higher than
            the number availble' do
      it "calls #paragraphs on a Wikiwhat::Text instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect_any_instance_of(Wikiwhat::Text).to receive(:paragraph).with(999)
        pigeon = Wikiwhat::Page.new("Columba livia", :num_paragraphs => 999)
      end
    end
  end
  describe "#image_list" do
    context "When #image_list is called on a Wikiwhat::Page instance" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_image_list, wikiwhat_page_pigeon_img_url)
        pigeon.image_list
        expect(Wikiwhat::Call).to have_received(:call_api).at_least(1).times
      end
      it "calls #list_image on a Wikiwhat::Media instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_image_list)
        expect_any_instance_of(Wikiwhat::Media).to receive(:list_images)
        pigeon.image_list
      end
    end
    context "when img_list => true is specified in the options hash" do
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_image_list, wikiwhat_page_pigeon_img_url)
        pigeon = Wikiwhat::Page.new("Columba livia", :img_list => true)
        expect(Wikiwhat::Call).to have_received(:call_api).at_least(1).times
      end
      it "calls #paragraphs on a Wikiwhat::Media instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_image_list)
        expect_any_instance_of(Wikiwhat::Media).to receive(:list_images)
        pigeon = Wikiwhat::Page.new("Columba livia", :img_list => true)
      end
    end
  end
  describe "#header" do
    context "When a header present in the article is specified in the options hash," do
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        pigeon = Wikiwhat::Page.new("Columba livia", :header => "Description")
        expect(Wikiwhat::Call).to have_received(:call_api)
      end
      it "calls #header on a Wikiwhat::Text instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect_any_instance_of(Wikiwhat::Text).to receive(:find_header).with("Description")
        pigeon = Wikiwhat::Page.new("Columba livia", :header => "Description")
      end
    end
    context "When #header is called on a Wikiwhat::Page instance with an argument," do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        pigeon.header("Description")
        expect(Wikiwhat::Call).to have_received(:call_api)
      end
      it "calls #header on a Wikiwhat::Text instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect_any_instance_of(Wikiwhat::Text).to receive(:find_header).with("Description")
        pigeon = Wikiwhat::Page.new("Columba livia", :header => "Description")
      end
    end
    context "When #header with no argument is called on a Wikiwhat::Page instance," do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "Raises an exception" do
        expect { pigeon.header }.to raise_error(ArgumentError)
      end
    end
    context "When a header not present in the article is specified in the options hash" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia", :header => "Biography") }
      it "Raises an exception" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_extracts)
        expect { pigeon.header }.to raise_error(Wikiwhat::WikiwhatError)
      end
    end
  end
  describe "#ref_list" do
    context "When refs => true is specified in the options hash" do
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions)
        pigeon = Wikiwhat::Page.new("Columba livia", :refs => true)
        expect(Wikiwhat::Call).to have_received(:call_api)
      end
      it "calls #refs on a Wikiwhat::Text instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions)
        expect_any_instance_of(Wikiwhat::Text).to receive(:refs)
        pigeon = Wikiwhat::Page.new("Columba livia", :refs => true)
      end
    end
    context "When #ref_list is called on a Wikiwhat::Page instance" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions)
        pigeon.ref_list
        expect(Wikiwhat::Call).to have_received(:call_api)
      end
      it "calls #find_ref_list on a Wikiwhat::Text instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions)
        expect_any_instance_of(Wikiwhat::Text).to receive(:refs)
        pigeon.ref_list
      end
    end
    context "When the page has no references" do
      it "Does something about having no references" do
        pending
      end
    end
  end
  describe "#sidebar_image" do
    context "When sidebar_img => true is specified in the options hash" do
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_image)
        pigeon = Wikiwhat::Page.new("Columba livia", :sidebar_img => true)
        expect(Wikiwhat::Call).to have_received(:call_api).at_least(1).times
      end
      it "calls #sidebar_image on a Wikiwhat::Text instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_image)
        expect_any_instance_of(Wikiwhat::Text).to receive(:sidebar_image)
        pigeon = Wikiwhat::Page.new("Columba livia", :sidebar_img => true)
      end
    end
    context "When #sidebar_image is called on a Wikiwhat::Page instance" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_image)
        pigeon.sidebar_image
        expect(Wikiwhat::Call).to have_received(:call_api).at_least(1).times
      end
      it "calls #sidebar_image on a Wikiwhat::Text instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_image)
        expect_any_instance_of(Wikiwhat::Text).to receive(:sidebar_image)
        pigeon.sidebar_image
      end
    end
    context "When no sidebar image exists" do
      let(:chad) { Wikiwhat::Page.new("Chad Muska") }
      it "Raises an exception" do
         Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_chad_revisions)
        expect { chad.sidebar_image }.to raise_error(Wikiwhat::WikiwhatError)
      end
    end
  end
    describe "#sidebar_thumbnail" do
    context "When sidebar_thumb => 250 is specified in the options hash" do
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_thumbnail)
        pigeon = Wikiwhat::Page.new("Columba livia", :sidebar_thumb => 250)
        expect(Wikiwhat::Call).to have_received(:call_api).at_least(1).times
      end
      it "calls #sidebar_thumbnail on a Wikiwhat::Media instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_thumbnail)
        expect_any_instance_of(Wikiwhat::Media).to receive(:sidebar_thumbnail)
        pigeon = Wikiwhat::Page.new("Columba livia", :sidebar_thumb => 250)
      end
    end
    context "When #sidebar_thumbnail is called on a Wikiwhat::Page instance" do
      let(:pigeon) { Wikiwhat::Page.new("Columba livia") }
      it "calls Call.api" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_thumbnail)
        pigeon.sidebar_thumbnail
        expect(Wikiwhat::Call).to have_received(:call_api).at_least(1).times
      end
      it "calls #sidebar_thumbnail on a Wikiwhat::Media instance" do
        Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_pigeon_revisions, wikiwhat_page_pigeon_sidebar_thumbnail)
        expect_any_instance_of(Wikiwhat::Media).to receive(:sidebar_thumbnail)
        pigeon.sidebar_thumbnail
      end
    end
    context "When no sidebar image exists" do
      let(:chad) { Wikiwhat::Page.new("Chad Muska") }
      it "Raises an exception" do
         Wikiwhat::Call.stub(:call_api).and_return(wikiwhat_page_chad_revisions)
        expect { chad.sidebar_image }.to raise_error(Wikiwhat::WikiwhatError)
      end
    end
  end
end
