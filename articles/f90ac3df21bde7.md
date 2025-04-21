---
title: "[Github Actions] Github Scriptは別ファイルに切り出せる"
emoji: "🗒️"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: [tips, githubactions]
published: true
publication_name: smartcamp
---
## 前置き

Github公式ActionであるGithub Scriptですが、今までインラインでしか書けないと思い込んでおりシンタックスハイライトも入力補完も効かない状態でコーディングしていました。

何とかならないものかと[README](https://github.com/actions/github-script?tab=readme-ov-file#run-a-separate-file)を読み漁ってみるとどうやら別ファイルに切り出せるらしい...

https://github.com/actions/github-script

## やってみる

:::message
このセクションで登場するコードは生成AIが記述したものになります。
動作は保証できないので雰囲気を感じ取る程度の温度感でご覧ください🙇‍♂️
:::

### ポイント

- スクリプトを配置するディレクトリに制限はない
  - 今回は`.github`直下に`scripts`ディレクトリを切ってそこに配置した
- 基本的にはCommonJSのモジュール機構を使用する(`require/module.export`)
  - [ESMを使用する方法](https://github.com/actions/github-script?tab=readme-ov-file#use-esm-import)も記載されているがちょっとだけ手順が増える
- github APIのクライアント(`github`)、 ワークフローのコンテキスト(`context`)などのGithub Scriptによって提供される引数は明示的に渡してあげる必要がある
- jsDocを使用することで型宣言も可能(当たり前だけど)
  - [Use scripts with jsDoc support](https://github.com/actions/github-script?tab=readme-ov-file#use-scripts-with-jsdoc-support)

```diff yaml: .github/workflows/create-issue.yaml
name: Create Issue Script

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  create-issue:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run external script
        uses: actions/github-script@v7
        with:
          script: |
+           const script = require('./.github/scripts/hello.js')
+           await script({github, context}) 
```

```js: .github/scripts/hello.js
const generateCreateIssueParams = (context) => ({
  owner: context.repo.owner,
  repo: context.repo.repo,
  title: '外部スクリプトからIssueを作成しました！',
  body: 'このIssueは.github/scripts/hello.jsから作成されました。\n\n' +
        '外部スクリプトを使用することで:\n' +
        '- シンタックスハイライト\n' +
        '- コード補完\n' +
        '- コードの再利用\n' +
        'などが可能になります！'
});

module.exports = async ({github, context}) => {
  // リポジトリに新しいIssueを作成
  const params = generateCreateIssueParams(context);
  await github.rest.issues.create(params);
  // 実行ログにメッセージを出力
  console.log('外部スクリプトの実行が完了しました！');
}; 
```

## まとめ

インラインで書かれたスクリプトだと可読性が下がることによってレビュワーにも負担をかけたり、予期しないバグを生んでしまったりと悩みの種になっていたのですが別ファイルに切り出すことによって可読性だけでなくコードの再利用性も向上させられたと思います。

間違っている部分や追加した方がいい情報があれば指摘いただけると助かります🙇‍♂️
