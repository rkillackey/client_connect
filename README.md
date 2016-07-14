# ClientConnect

## Overview
ClientConnect is a platform for connecting with potential incoming clients. [Need to write more copy]

## Dependencies

* Ruby 2.2.3
* Rails 5.0.0.rc1

## Twilio Setup

  Add the following environment variables from your Twilio account to the `application.yml` file:
   ```
   TWILIO_ACCOUNT_SID: your account sid
   TWILIO_AUTH_TOKEN: your auth token
   TWIML_APPLICATION_SID: your twiml app sid
   TWILIO_PHONE_NUMBER: your twilio phone number
   ```

## Slack Setup

  * Create Slack bot.
  * Add the following environment variable to the `application.yml` file:

    ```
    SLACK_API_TOKEN: your slack bot API token
    ```

## Getting Started

1. Install dependencies
   ```
   bundle install
   ```
2. Create database, run migrations, seed database:
   ```
   rake db:create db:migrate db:seed
   ```
3. Run the server:
   ```
   rails server
   ```
4. Make server publicly accessible using ngrok:
   ```
   ngrok http 3000
   ```
5. Add ngrok host as endpoint for TwiML app.
