# Mac OS X のセットアップ手順

## 最低限のトラックパッド設定

システム環境設定 -> トラックパッド -> ポイントとクリック -> 軌跡の速さ（一番最速に）
システム環境設定 -> トラックパッド -> スクロールとズーム -> スクロールの方向: ナチュラル (チェックを外す)
システム環境設定 -> アクセシビリティ -> マウスとトラックパッド -> トラックパッドオプション -> ドラッグを有効にする (3本指のドラッグ)

## 最低限のキーボード設定

システム環境設定 -> キーボード -> キーボード -> 装飾キー -> Apple内蔵キーボード/トラックパッド (Caps Lockキー: Control)
システム環境設定 -> キーボード -> キーボード -> キーのリピート -> 早い
システム環境設定 -> キーボード -> キーボード -> リピート入力認識までの時間 -> 早い

## homebrewのインストール (terminal.app)

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

(上記コマンドで xcode のインストールも始まる)
(最新のコマンドはhomebrewのサイトを確認)

### cask も入れておく

```
brew cask
```

## gitのインストール

この時点でgitは入っていた

## Dropbox

```
brew cask install dropbox
```

- 選択型同期で必要なものを同期
    - `Keys`, `Memo` など
- 設定など必要なものはコピーやシンボリックリンクを貼っておく

## ssh-keygen

```
ssh-keygen -t ed25519 -C 1531860+itkr@users.noreply.github.com
```

githubに公開鍵登録

## 設定用リポジトリ

```
brew install ghq
```

```
ghq get git@github.com:itkr/Local-playbook.git
ghq get git@github.com:itkr/dotfiles.git
```

```
ln -s ~/ghq ~/Projects
```

```
mkdir ~/.vim/tmp
```

## ansible

```
brew install ansible
```

## iterm2

ansibleに任せる？

```
export DIR_CONF='~/Projects/github.com/itkr/dotfiles/files/.iterm2'
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true
defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string ${DIR_CONF}
```

## IME

```
brew cask install google-japanese-ime
```

システム環境設定 -> キーボード -> キーボード -> 入力ソース -> +

## 時計

秒表示・日付表示

## スクリーンセーバー

システム環境設定 -> デスクトップとスクリーンセーバ -> スクリーンセーバ -> ホットコーナー
右上でスクリーンセーバー起動する

## Copilot

https://docs.github.com/ja/copilot/getting-started-with-github-copilot?tool=vimneovim#prerequisites-3
