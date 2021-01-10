CLOUD_SDK_PATH=$HOME/google-cloud-sdk

# `homebrew cask`でインストールしたとき
if [ -x /usr/local/Caskroom/google-cloud-sdk ]; then
    CLOUD_SDK_PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
fi

if [ -x $CLOUD_SDK_PATH ]; then
    # The next line updates PATH for the Google Cloud SDK.
    source $CLOUD_SDK_PATH/path.zsh.inc
    # The next line enables zsh completion for gcloud.
    source $CLOUD_SDK_PATH/completion.zsh.inc
fi

export CLOUDSDK_PYTHON="${HOME}/.pyenv/versions/global/bin/python"
