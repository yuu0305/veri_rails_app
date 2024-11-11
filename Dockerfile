# ベースイメージ
FROM ruby:3.2

# Node.jsとnpm、Yarn、PostgreSQLクライアントをインストール
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client && \
    npm install -g yarn

# 作業ディレクトリを設定
WORKDIR /app

# GemfileとGemfile.lockをコピーし、インストール
COPY Gemfile* ./
RUN bundle install

# アプリケーションコードをコピー
COPY . .

# サーバーポート
EXPOSE 3000

# サーバーの起動コマンド
CMD ["bin/rails", "server", "-b", "0.0.0.0"]