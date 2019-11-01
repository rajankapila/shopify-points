# README

## Shopify Points App

This app can be added to a user's Shopify store to allow users to accumulate points based on total dollars spent on your store.
You are able to set the number of points earned per dollar spent. If the this value is set to zero, no points are accumulated.
An email will be sent to customers when they place orders informing them about points earned and total points on their account.

### Specifications

This is built with Ruby on Rails 5 using Sidekiq which uses Redis for deferred job management and Figaro for configuration management. This uses a gmail account to send SMTP mail. To create a shopify app, you must register (https://www.shopify.ca/partners) as a partner and setup a private app to obtain an API key and API secret key. You will need to setup your App URL and add a Whitelisted redirection URL for the auth callback (<your-url>/auth/shopify/callback)

Here are some good resources for creating and setting up a Shopify App

https://github.com/Shopify/shopify_app

https://help.shopify.com/api/tutorials/building-public-app

https://github.com/Shopify/example-ruby-app

https://medium.com/@chris.chimen/build-shopify-app-with-ruby-on-rails-for-beginer-part-1-40471da7d607

You will also need to install Redis (brew install redis) on your machine.

### Deployment

In the /config directory you will find application_sample.yml. Rename this to application.yml and fill in the variable values.

Run these commands in a terminal

```
bundle install
rake db:migrate
bundle exec sidekiq -q default -q mailers
```

in a separate terminal window

```
rails s
```

Setup ngrok (https://ngrok.com/) or something similar to acquire a public url to funnel calls to your local machine

```
./ngrok http 3000
```

### Installing on Shopify Store

Go to your public URL and enter the store URL into the input box and agree to install the app.
