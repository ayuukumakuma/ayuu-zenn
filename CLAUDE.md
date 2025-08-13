# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

Zenn CLIを使用した技術記事管理リポジトリです。SmartCampの企業アカウント（`publication_name: smartcamp`）へ記事を投稿します。

## 開発環境

- Node.js: 24.5.0
- pnpm: 10.14
- バージョン管理: mise（mise.tomlで定義）

## よく使うコマンド

### 新規記事作成
```bash
# SmartCamp企業アカウント向けの新規記事を作成し、画像ディレクトリも同時に作成
just new
```
これは以下を実行します：
1. `npx zenn new:article --publication-name smartcamp --published true`
2. 最新記事用の画像ディレクトリを `images/` 以下に自動作成

### Zenn CLI コマンド
```bash
# ローカルでプレビュー（http://localhost:8000）
npx zenn preview

# 新規記事作成（基本コマンド）
npx zenn new:article

# 新規本作成
npx zenn new:book

# 記事一覧表示
npx zenn list:articles

# 本一覧表示
npx zenn list:books
```

## プロジェクト構造

```
ayuu-zenn/
├── articles/           # 記事のMarkdownファイル
│   └── *.md           # 各記事（ランダムなIDが付与される）
├── images/            # 記事用画像
│   └── [記事ID]/      # 記事ごとの画像ディレクトリ
├── Justfile           # タスクランナー設定
├── mise.toml          # バージョン管理設定
└── package.json       # npm設定（zenn-cli依存）
```

## 記事の構造

記事は以下のフロントマターを持ちます：
```yaml
---
title: "記事タイトル"
emoji: "📝"
type: "tech"              # tech: 技術記事 / idea: アイデア
topics: [tag1, tag2]      # 最大5つまで
published: true           # 公開状態
publication_name: smartcamp  # 企業アカウント名
---
```

## 画像の管理

記事内の画像は `/images/[記事ID]/` ディレクトリに配置し、以下のように参照します：
```markdown
![画像の説明](/images/[記事ID]/image.png)
```