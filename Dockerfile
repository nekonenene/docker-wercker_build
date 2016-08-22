FROM ubuntu:trusty

LABEL Description="npm, pip, bundler" Vendor="nekonenene" Version="0.3"

## 文字コード設定
RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:en
ENV LC_ALL ja_JP.UTF-8

ENV NODE_VERSION 6.4.0

## 基本的なパッケージのインストール
RUN apt-get update && \
	apt-get install -y \
		make \
		curl \
		ssh \
		git \
		nodejs \
		npm \
		python \
		ruby

## nodejs, npm を最新に
# n で nodejs のバージョン管理
RUN npm cache clean && \
	npm install -g n && \
	n $NODE_VERSION

# 最新の npm を取得
RUN curl -L https://npmjs.org/install.sh | sh

# apt で入れた nodejs を削除
RUN apt-get purge -y nodejs npm


## pip で fabric をインストール
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python && \
	apt-get install -y python-dev && \
	pip install fabric

## bundler をインストール
RUN gem install bundler

## 不要なパッケージを削除
RUN apt-get autoremove -y
