# The Barbican

This is the sample application from the talk The Barbican about using 
[Kickstarter's](https://github.com/kickstarter/)[Rack::Attack](https://github.com/kickstarter/rack-attack) 
to throttle malicious requests to a Rails API.

See the [slides](talk/slides.pdf) from the talk for reference.

# Demo app setup instructions

## Rails app

#### Create a new Rails application
```
rails new barbican-arlington --database=postgresql
```

#### Change directory and set Ruby version
```
cd barbican-arlington
echo 'ruby "2.4.1"' >> Gemfile
```

## GitHub

#### Initial Git commit
```
git add .
git commit -m "Initial commit"
```

#### Create a repository on GitHub
```
barbican-arlington
```

#### Push the app to GitHub
```
git remote add origin https://github.com/USERNAME/barbican-arlington.git
git push -u origin master
```

## Heroku

#### Create a Heroku app
```
heroku create
```

#### Deploy the app to Heroku
```
git push heroku master
```

#### Open your app
```
heroku open
```

## Setup a target

#### Create a Targets controller
```
rails generate controller Targets index create
```

#### Setup resource routes
```
resources :targets, only: [:index, :create]
```

#### Remove CSRF protection from TargetsController
```
skip_before_action :verify_authenticity_token
```

## Protect the target

#### Add the `rack-attack` gem to the `Gemfile`
```
gem 'rack-attack'
```

#### Install dependencies
```
bundle install
```

#### Tell your app to use the Rack::Attack middleware in `config/application.rb`
```
config.middleware.use Rack::Attack
```

#### Turn on caching in dev
```
rails dev:cache
```

#### Add `config/initializers/rack-attack.rb`
```
class Rack::Attack
end
```

#### Add throttling
```
throttle('req/ip', :limit => 10, :period => 1.minutes) do |req|
  req.ip
end
```

#### Add throttling for non-GET requests (POST, PATCH, PUT, DELETE)
```
throttle('req/ipnonget', :limit => 3, :period => 1.minutes) do |req|
  req.ip unless req.get?
end
```

# Extras

## Redis

#### Add Redis to Gemfile
```
gem 'redis-rails'
```

#### Set development cache store to Redis in `development.rb`
```
config.cache_store = :redis_store, 'redis://localhost:6379/0'
```

#### Set production cache store to Redis in `productino.rb`
```
config.cache_store = :redis_store, ENV['REDIS_URL']
```

##### Sponsored by
[![FullStack Labs](https://www.fullstacklabs.co/img/fullstack-labs-logo-dark-e8f52558.png)](https://www.fullstacklabs.co)
