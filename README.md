Locaweb Challenge
===================

This API provides tweets and Twitter users which complains about Locaweb products.

## Dependencies

- Ruby 2.4.0
- Rails 5.0.3

Guidelines
===============

### Interactors (Use cases)

- Contains all the business logic of the application. It should have a single responsibility and should response to the `call` method.

### Clients

- It should be a communication layer that abstracts external services.

### Resources

- It contains application response resources. It should be only a mapping between an internal object and the desired response.

Setup
===============

First, be sure you are using Ruby 2.4.0. You may use [`rbenv`](https://github.com/rbenv/rbenv) for Ruby version management.
Then, install `bundler` for this Ruby version

```
gem install bundler
```

Install application dependencies

```
bundle install
```

Tests
--------------------------------------

You can run the tests by running

```
bundle exec rspec
```

Linter
--------------------------------------

You can lint your code by running

```
bundle exec rubocop
```

Running application locally
--------------------------------------

You can start the application using `puma`. It will be available on port 3000.

```
bundle exec puma
```

You can also use Docker to start the application.

```
docker-compose up --build -d
```

Considerations
===============

I tried not to use any external library on the development. Most of them are test and debugger utilities. Rubocop is used to lint the code and to analyze its complexity. I used Figaro library for configuration parameters like Twitter and Tweeps URLs.
Rails were chosen due to my familiarity with this framework, but since there is no need for a database, ActiveRecord were removed.
