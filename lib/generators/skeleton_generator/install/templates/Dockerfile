# syntax=docker/dockerfile:1.3-labs
FROM ruby:3.2.1-slim AS development

ENV APP_ROOT /opt/app
ENV LANG C.UTF-8
ENV RUBYOPT="--yjit"

RUN <<eos
apt-get update -qq && apt-get install -y build-essential libpq-dev vim apt-transport-https curl git
gem install bundler
eos

RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

COPY . $APP_ROOT

EXPOSE 3000

FROM development AS builder
ENV RAILS_ENV=production
ENV RACK_ENV=production
RUN <<eos
bundle config set path vendor/bundle
bundle install --jobs=4 --retry=3
eos

FROM ruby:3.2.1-slim AS production
ENV APP_ROOT /opt/app
ENV LANG C.UTF-8
ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV RUBYOPT="--yjit"
EXPOSE 3000

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

COPY --from=builder $APP_ROOT $APP_ROOT
RUN bundle config set path vendor/bundle

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
