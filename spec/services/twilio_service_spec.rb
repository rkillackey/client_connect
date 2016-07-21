require 'rails_helper'

describe TwilioService do
  subject { TwilioService }

  let(:contact) { create(:contact) }
  let(:xml_response) { Nokogiri::XML::Builder.new { |xml| xml.root { xml.Response } } }
  let(:json_response) { { test: 'test' }.to_json }

  describe '#answer_call' do
    before(:each) {
      allow(SlackWebClient).to receive(:post_message)
      allow(TwilioTwiml).to receive(:dial_twiml).and_return(xml_response)
    }

    it 'returns xml response from twilio' do
      response = subject.send(:answer_call, { contact: contact, 'From' => 'phone-number' })
      expect(response).to eq(xml_response.to_xml)
    end
  end

  describe '#finish_call' do
    before(:each) { allow(TwilioTwiml).to receive(:voicemail_twiml).and_return(xml_response) }

    it 'returns xml response from twilio' do
      response = subject.send(:finish_call, { 'DialCallStatus' => 'no-answer', 'Caller' => 'phone-number' })
      expect(response).to eq(xml_response.to_xml)
    end
  end

  describe '#post_slack_call' do
    before(:each) { allow(SlackWebClient).to receive(:post_message).and_return(json_response) }

    it 'returns json response from SlackWebClient' do
      response = subject.send(:post_slack_call, { 'Direction' => 'inbound' })
      expect(response).to eq(json_response)
    end
  end

  describe '#handle_voicemail_recording' do
    before(:each) {
      allow(SlackWebClient).to receive(:post_message)
      allow(TwilioTwiml).to receive(:hangup_twiml).and_return(xml_response)
    }

    it 'returns xml response from twilio' do
      response = subject.send(:handle_voicemail_recording)
      expect(response).to eq(xml_response.to_xml)
    end
  end

  describe '#text_response' do
    before(:each) {
      allow(SlackWebClient).to receive(:post_message)
      allow(TwilioTwiml).to receive(:text_twiml).and_return(xml_response)
    }

    it 'returns xml response from twilio' do
      response = subject.send(:text_response)
      expect(response).to eq(xml_response.to_xml)
    end
  end
end
