# SimpleSoundPlayer

SoundFontを読み込んで音の再生と停止を提供するライブラリです。
SoundFontファイルは別途入手する必要があります。

※SoundFontは、ピアノなどの様々な音色のデータフォーマットです。参考：[wikipedia SoundFont](https://ja.wikipedia.org/wiki/SoundFont)

# 使い方

## セットアップ
```swift
let sondFontURL = // SoundFontのパスを表すURL
let player = SimpleSoundPlayer(soundBankURL: soundFontURL)
try! player.prepare()
```

## 再生と停止

```swift
// 音を再生する
player.startNote(60, velocity: 60) // ピアノの中央ドの音を再生する
// 音を止める
player.stopNote(60)
```

# デモ

[SimpleSoundPlayerDemo](https://github.com/raku-pro/SimpleSoundPlayerDemo)を確認してください。

# LICENSE

MIT
