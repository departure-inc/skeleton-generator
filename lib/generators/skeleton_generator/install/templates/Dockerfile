FROM ruby:3.0.2-slim AS development

ENV APP_ROOT /opt/app

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev vim apt-transport-https curl git

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update -qq && apt-get install -y yarn
RUN gem install bundler -v 2.2.22

RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

COPY . $APP_ROOT

EXPOSE 3000

FROM development AS builder
ENV RAILS_ENV=production
ENV RACK_ENV=production
RUN bundle install --jobs=4 --retry=3 --path=vendor/bundle
RUN yarn install
RUN bin/rails webpacker:compile

FROM ruby:3.0.2-slim AS production
ENV APP_ROOT /opt/app
ENV LANG C.UTF-8
ENV RAILS_ENV=production
ENV RACK_ENV=production
EXPOSE 3000

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

COPY --from=builder $APP_ROOT $APP_ROOT
RUN bundle config set path vendor/bundle

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
