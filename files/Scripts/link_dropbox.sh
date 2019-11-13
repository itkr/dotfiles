# Dropboxと連携するためのシンボリックリンクを設定する

# TODO: Ansibleを使うようにする

# Dropboxの場所
DROPBOX_HOME="${HOME}/Dropbox"

# iTunesライブラリ（母艦以外）
# シンボリックリンクを使わずにiTunesの設定で操作できるが、バージョンの違いによってうまく行かなかったので追加
ln -s ${DROPBOX_HOME}/Music/iTunes/iTunes\ Media/Music ${HOME}/Music/iTunes/iTunes\ Media/Music

# iTunesライブラリ（母艦）
# ln -s ${DROPBOX_HOME}/Music/iTunes ${HOME}/Music/iTunes

# memoコマンドの保存先
# シンボリックリンクではなく`memo config`コマンドでも変更できる
ln -s ${DROPBOX_HOME}/Memo/_posts ${HOME}/.config/memo/_posts
