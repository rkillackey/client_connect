require 'rails_helper'

describe TwilioTwiml do
  subject { TwilioTwiml }

  describe '#dial_twiml' do
    context 'when phoneNumber is provided' do
      it 'dials to phone number' do
        response = subject.send(:dial_twiml, { phoneNumber: 'phone-number' })
        xml = load_xml(response)

        expect(xml.at_xpath('//Response//Dial//Number').content)
          .to eq('phone-number')
      end
    end

    context 'when phoneNumber is not provided' do
      it 'dials to client connect' do
        response = subject.send(:dial_twiml)
        xml = load_xml(response)

        expect(xml.at_xpath('//Response//Dial//Client').content)
          .to eq('client_connect')
      end
    end
  end

  describe '#voicemail_twiml' do
    it 'returns say twiml with correct message' do
      response = subject.send(:voicemail_twiml)
      xml = load_xml(response)

      expect(xml.at_xpath('//Response//Play').children[0].content).to eq('LPL1.mp3')
    end

    it 'returns record twiml' do
      response = subject.send(:voicemail_twiml, { message: 'voicemail-message' })
      xml = load_xml(response)

      expect(xml.at_xpath('//Response').children[1].name).to eq('Record')
    end
  end

  describe '#text_twiml' do
    it 'returns sms twiml to the correct number' do
      response = subject.send(:text_twiml, { From: 'phone-number' })
      xml = load_xml(response)

      expect(xml.at_xpath('//Response//Sms').attributes['to'].value).to eq('phone-number')
    end
  end

  describe '#hangup_twiml' do
    it 'returns twiml to hangup call' do
      response = subject.send(:hangup_twiml)
      xml = load_xml(response)

      expect(xml.at_xpath('//Response').children[0].name).to eq('Hangup')
    end
  end

  private

  def load_xml(xml)
    Nokogiri::XML(xml.to_xml)
  end
end
