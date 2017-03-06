# Dropboxと連携するためのシンボリックリンクを設定する

# Dropboxの場所
DROPBOX_HOME="${HOME}/Dropbox\ \(個人\)"

# iTunesライブラリ
# ln -s ${DROPBOX_HOME}/Music/iTunes ${HOME}/Music/iTunes
ln -s ${DROPBOX_HOME}/Music/iTunes/iTunes\ Media/Music ${HOME}/Music/iTunes/iTunes\ Media/Music

# memoコマンドの保存先
ln -s ${DROPBOX_HOME}/Memo/_posts ${HOME}/.config/memo/_posts
