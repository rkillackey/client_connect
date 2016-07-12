FactoryGirl.define do
  factory :contact do
    time_contacted  Time.now
    data {
            {
               "To"=>"+13122199286",
               "Body"=>"This is a test",
               "From"=>"+16105054327",
               "ToZip"=>"",
               "SmsSid"=>"SM8a14ed40c8f6343c1c98c492fb9af718",
               "ToCity"=>"",
               "action"=>"text",
               "FromZip"=>"19406",
               "ToState"=>"IL",
               "FromCity"=>"NORRISTOWN",
               "NumMedia"=>"0",
               "FromState"=>"PA",
               "SmsStatus"=>"received",
               "ToCountry"=>"US",
               "AccountSid"=>"AC4b884514f60d66cbe00063459d870c57",
               "ApiVersion"=>"2010-04-01",
               "MessageSid"=>"SM8a14ed40c8f6343c1c98c492fb9af718",
               "controller"=>"twilio",
               "FromCountry"=>"US",
               "NumSegments"=>"1",
               "SmsMessageSid"=>"SM8a14ed40c8f6343c1c98c492fb9af718"
           } 
         }
  end
end
