FROM ruby:2.4.2

WORKDIR /usr/src/app

ADD Gemfile Gemfile.lock /usr/src/app/
RUN bundle install -j20

ADD . /usr/src/app
