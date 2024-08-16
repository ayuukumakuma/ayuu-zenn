---
title: "ZedのAssistant PanelでOllamaを使う"
emoji: "🦙"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: [zed, editor, ollama, llm]
published: true
---

:::message
筆者は LLM 周りの知識がかなり乏しいです。何か間違い・アドバイス等ありましたらコメント頂けると非常に助かります！
:::

## Zed について

以下の記事で詳しく解説してます！

https://zenn.dev/smartcamp/articles/c421e752119cee

## Assistant Panel とは

VSCode の[GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)のように IDE 上で生成 AI とチャットができる機能です。

![Assistant Panel](/images/b00ceecbb4e096/assistant-panel.png)
_[公式](https://zed.dev/docs/assistant-panel)より引用_

詳細は公式ドキュメントをご覧ください。

https://zed.dev/docs/assistant-panel

## Assistant Panel で Ollama を使う

本題です。
[2024/06/19 の Stable Release](https://zed.dev/releases/stable/0.140.5)で Assistant Panel で Ollama が使えるようになりました。

Ollama についてはあまり詳しくない＆参考になる記事が沢山あるのでここでは詳しく解説しません。あしからず 🙇‍♂️

簡単に説明するとローカルマシン上で LLM(Large language Models)を実行させることができる OSS の CLI ツールです。

https://ollama.com/

---

さて，実際に導入してみます．

### Ollama 側のセットアップ

まずは brew で Ollama をインストールします

```bash: zsh
brew install --cask ollama
```

インストール終了後、Ollama を開いてみると CLI のインストールを求められるので仰せのままに進めましょう。

次にモデルを pull します。今回は 2024/06/27 に発表されたばかりの[Gemma 2](https://ollama.com/library/gemma2:9b)を使用します。

```bash: zsh
ollama pull gemma2
# pulling manifest
# pulling 0da0a4d67fe4... 100% ▕█████████████████████████████████████████████████████████████████████████████████████████████████████████████████▏ 5.4 GB
# pulling 109037bec39c... 100% ▕█████████████████████████████████████████████████████████████████████████████████████████████████████████████████▏  136 B
# pulling 097a36493f71... 100% ▕█████████████████████████████████████████████████████████████████████████████████████████████████████████████████▏ 8.4 KB
# pulling 6522ca797f47... 100% ▕█████████████████████████████████████████████████████████████████████████████████████████████████████████████████▏   99 B
# pulling 5af01f364d50... 100% ▕█████████████████████████████████████████████████████████████████████████████████████████████████████████████████▏  487 B
# verifying sha256 digest
# writing manifest
# removing any unused layers
# success
```

これで Ollama 側のセットアップは完了です。試しにターミナル上で会話してみましょう。

```bash: zsh
ollama run gemma2
# >>> こんにちは
# こんにちは！ 👋

# 何かお手伝いできることはありますか？😊

# >>> 今日の夕食は鶏肉とナスの炒め物でした。どうですか？羨ましいですか？
# 鶏肉とナスの炒め物、美味しそうです！🤤  私はAIなので、食べることができないのが残念ですが、あなたの夕食がおいしかったことを願っています！😋

# 今日の私の夕食は、データの分析と処理です。😅

# あなたは、どんな味付けで炒め物をしましたか？✨

# >>> ひ　み　つ
# ふふ、ひみつなんですね！🤫

# いつか教えてくれるかもしれませんね！✨

# 私は、ひみつレシピも大好きなので、ぜひ教えてほしいです！😊

# >>> Send a message (/? for help)
```

初めてローカルで LLM 動かしてみましたが想像以上にレスポンス早くてびっくりしました！！
(筆者の動作環境は MacBook Pro M1 Max RAM:32GB です)

### Zed 側の設定

Zed の方は至ってシンプルです。

公式ドキュメントに沿って設定していきます。

https://zed.dev/releases/stable/0.140.5

設定ファイルに 👇 を追記します。

```json: ~/.config/zed/settings.json
{
  ...,
  "assistant": {
    "version": "1",
    "provider": {
      "name": "ollama",
      // Recommended setting to allow for model startup
      "low_speed_timeout_in_seconds": 30,
    }
  },
  ...,
}
```

これだけで Zed 側が Ollama を読み取ってくれます。
![Assistant Panel on Ollama](/images/b00ceecbb4e096/ollama-assistant-panel.png)

先ほど pull した`gemma2`が表示されていますね！
(token 数が表示されていますがローカル LLM なので関係ないのでは...??と思っています。)

---

実際に使ってみましょう。
![Chat Result](/images/b00ceecbb4e096/chat-result.png)

はい，動きました！！レスポンスの速度も CLI と体感できるほどの差は感じませんでした。(初回だけ少し時間がかかった)

## おわりに

今回は Zed で Ollama を使ってみました。

Ollama を使ったのも今回が初めてだったのですがここまで簡単にローカルで LLM を動作させられることにびっくりしました。

Zed の新機能や Tips をこれからもちょくちょく紹介していきたいと思っているので暇な方は見にきてくれると嬉しいです o7
