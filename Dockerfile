FROM ruby:2.4.0

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app
COPY . /usr/src/app

RUN gem install bundler
RUN bundle install

EXPOSE 3000
CMD ["bundle", "exec", "puma"]
