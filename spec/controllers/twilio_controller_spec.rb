require 'rails_helper'

describe TwilioController do
  let(:xml_response) { Nokogiri::XML::Builder.new { |xml| xml.root { xml.Response } } }

  describe 'POST #connect' do
    before(:each) { allow(TwilioService).to receive(:answer_call).and_return(xml_response) }

    it 'renders xml response' do
      post :connect, params: { From: 'phone-number' }
      expect(response.body).to eq(xml_response.to_xml)
    end
  end

  describe 'POST #answer' do
    before(:each) { allow(TwilioService).to receive(:post_slack_call).and_return(xml_response) }

    it 'renders json response from Slack' do
      post :answer
      expect(response.body).to eq(xml_response.to_xml)
    end
  end

  describe 'POST #complete' do
    before(:each) { allow(TwilioService).to receive(:finish_call).and_return(xml_response) }

    it 'renders hangup xml response if call was answered and completed' do
      post :complete, params: { DialCallStatus: 'answered' }
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
