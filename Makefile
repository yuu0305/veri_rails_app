# Makefile for Dockerized Rails application

# コンテナ名やサービス名の定義
COMPOSE=docker compose
WEB_SERVICE=veri_rails_app-web-1
DB_SERVICE=db

# デフォルトのターゲット（何も指定しない場合に実行される）
default: help

# アプリケーションの初期化
setup: build db_setup
	@echo "Railsアプリケーションのセットアップが完了しました。"

# Dockerイメージのビルド
build:
	$(COMPOSE) build
	@echo "Dockerイメージのビルドが完了しました。"

# Dockerコンテナの起動
up:
	$(COMPOSE) up
	@echo "Dockerコンテナをバックグラウンドで起動しました。"

up-d:
	$(COMPOSE) up -d
	@echo "Dockerコンテナをバックグラウンドで起動しました。"

# Dockerコンテナの停止
down:
	$(COMPOSE) down
	@echo "Dockerコンテナを停止しました。"

# Railsデータベースの作成と初期設定
migrate:
	make up-d
	docker compose exec web rails db:migrate
	make down
	@echo "マイグレーション実行しました"

db_setup: up
	$(COMPOSE) run $(WEB_SERVICE) rails db:create db:migrate db:seed
	@echo "データベースのセットアップが完了しました。"

# Railsコンソールを開く
console:
	$(COMPOSE) run $(WEB_SERVICE) rails console

# Dockerコンテナにシェルで入る
shell:
	docker exec -it $(WEB_SERVICE) bash

# Railsサーバーの起動
server:
	$(COMPOSE) up $(WEB_SERVICE)

# クリーンアップ（未使用のDockerリソースを削除）
clean:
	$(COMPOSE) down --volumes --remove-orphans
	docker system prune -f
	@echo "Docker環境をクリーンアップしました。"

pry:
	docker start veri_rails_app-web-1
	docker attach veri_rails_app-web-1

# ヘルプの表示
help:
	@echo "利用可能なコマンド:"
	@echo "  make setup        - 初回セットアップ（ビルド、DB作成）"
	@echo "  make build        - Dockerイメージのビルド"
	@echo "  make up           - コンテナの起動"
	@echo "  make down         - コンテナの停止"
	@echo "  make db_setup     - データベースのセットアップ"
	@echo "  make console      - Railsコンソールを開く"
	@echo "  make shell        - Dockerコンテナにシェルで入る"
	@echo "  make server       - サーバーを起動"
	@echo "  make clean        - 未使用リソースの削除"
	@echo "  make help         - このヘルプを表示"
