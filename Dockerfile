FROM ruby:2.6.5
RUN apt-get update 
RUN apt-get install default-libmysqlclient-dev

RUN gem update --system
RUN gem install mysql2
RUN gem install bundle
RUN gem install bundler

RUN mkdir /notification-ms
WORKDIR /notification-ms
ADD Gemfile /notification-ms/Gemfile
ADD Gemfile.lock /notification-ms/Gemfile.lock
RUN bundle install
ADD . /notification-ms

EXPOSE 4001