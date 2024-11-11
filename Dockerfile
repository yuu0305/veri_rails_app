# Rubyのベースイメージを使用（最新のRubyバージョンを指定）
FROM ruby:3.1

# Node.jsとPostgreSQLクライアントのインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# 作業ディレクトリの設定
WORKDIR /app

# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# アプリケーションのコードをコピー
COPY . /app
