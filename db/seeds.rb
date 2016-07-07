# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Contact.create([
  {
    time_contacted: Time.now,
    data: {
            'From' => '+15005550006',
            'FromCity' => 'Chicago',
            'FromState' => 'IL',
            'FromCountry' => 'US',
            'FromZip' => '60640',
            'CallSid' => SecureRandom.hex,
            'AccountSid' => 'AC12345678',
            'To' => '+13122199286'
          },
    notes: "Caller is interesed in building a CMS for a marketing site. Timeline is 3 months. Budget is $10,000 per month."
  },
  {
    time_contacted: Time.now - 2.hours,
    data: {
            'From' => '+15005550006',
            'FromCity' => 'Philadelphia',
            'FromState' => 'PA',
            'FromCountry' => 'US',
            'FromZip' => '19019',
            'CallSid' => SecureRandom.hex,
            'AccountSid' => 'AC12345678',
            'To' => '+13122199286'

          },
    notes: "Caller is interested in building an Ionic app. Timeline is 6 months. Budget is $50,000."
  }
])

p 'Seeded successfully.'
p "#{Contact.count} Contacts have been created."
