FROM ruby:2.7.4

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y sqlite3 vim --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN gem install bundler:2.3.26
RUN bundle lock --add-platform x86_64-linux
# RUN bundle config --global frozen 1
RUN bundle install

COPY . /usr/src/app
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD rails server -b 0.0.0.0
