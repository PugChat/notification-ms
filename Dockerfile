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

CMD ["bash","-c","sleep 40 && rm -f tmp/pids/server.pid && bundle exec rails db:create && bundle exec rails db:migrate && bundle exec rails db:seed && bundle exec rails s -p 4001 -b '0.0.0.0'"]

EXPOSE 4001
