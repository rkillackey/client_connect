require 'rails_helper'

describe TwilioController do
  let(:xml_response) { Nokogiri::XML::Builder.new { |xml| xml.root { xml.Response } } }
  subject { TwilioController.new }

  describe 'POST #connect' do
    before(:each) { allow(TwilioService).to receive(:answer_call).and_return(xml_response) }

    it 'renders xml response' do
      post :connect, params: { From: 'phone-number' }
      expect(response.body).to eq(xml_response.to_xml)
    end
  end

  describe 'POST #answer' do
    pending
    # before(:each) { allow(TwilioService).to receive(:post_slack_call) }
    #
    # it 'renders json response from Slack' do
    #   pending
    # end
  end

  describe 'POST #complete' do
    before(:each) { allow(TwilioService).to receive(:send_to_voicemail).and_return(xml_response) }

    it 'renders xml response' do
      post :complete, params: { DialCallStatus: 'no-answer' }
      expect(response.body).to eq(xml_response.to_xml)
    end
  end

  describe 'POST #voicemail' do
    before(:each) { allow(TwilioService).to receive(:handle_voicemail_recording).and_return(xml_response) }

    it 'renders xml response' do
      post :voicemail
      expect(response.body).to eq(xml_response.to_xml)
    end
  end

  describe 'POST #text' do
    before(:each) { allow(TwilioService).to receive(:text_response).and_return(xml_response) }

    it 'renders xml response' do
      post :text, params: { From: 'phone-number' }
      expect(response.body).to eq(xml_response.to_xml)
    end
  end
end
