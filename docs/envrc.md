## GitHubの複数アカウントを使う場合

別アカウントを使うリポジトリ用のディレクトリ配下で `.envrc` を作成し、[direnv](https://github.com/direnv/direnv)で環境変数を変更して使用するsshキーなどを変更

```sh
export GIT_COMMITTER_NAME="Shota Itakura"
export GIT_COMMITTER_EMAIL="1531860+itkr@users.noreply.github.com"
export GIT_AUTHOR_NAME="Shota Itakura"
export GIT_AUTHOR_EMAIL="1531860+itkr@users.noreply.github.com"
export GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa_itkr"
```
