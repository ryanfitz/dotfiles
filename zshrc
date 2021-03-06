# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx brew node npm rbenv ssh-agent go)

source $ZSH/oh-my-zsh.sh

NPM_MODULE_PATH=/usr/local/share/npm/bin
DART_SDK=$HOME/bin/dart/dart-sdk
ANDROID_SDK=$HOME/bin/adt-bundle-mac/sdk
PYTHON_PATH=/usr/local/share/python

export ANDROID_HOME=$ANDROID_SDK
export EDITOR=vim
# Customize to your needs...
export PATH=$HOME/bin:$PYTHON_PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$DART_SDK/bin:$NPM_MODULE_PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
export AWS_CLOUDFORMATION_HOME="/usr/local/Cellar/aws-cfn-tools/1.0.11/jars"
export AWS_CREDENTIAL_FILE="$HOME/.ec2/AWSCredentials.txt"

export AWS_CONFIG_FILE="$HOME/.ec2/personal/config.txt"

export GOPATH=$HOME/go

source /Users/fitz/.nvm/nvm.sh
source /usr/local/bin/aws_zsh_completer.sh
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

function dev_instance_id() {
  aws ec2 describe-instances --filters "Name=tag:Name,Values=dev-instance-ryan" --query "Reservations[0].Instances[0].InstanceId" --profile dev --output text
}

function dev_instance_hostname() {
  aws ec2 describe-instances --filters "Name=tag:Name,Values=dev-instance-ryan" --query "Reservations[0].Instances[0].PublicDnsName" --profile dev --output text
}

function start-dev-instance() {
  awsid=$( dev_instance_id )
  aws ec2 start-instances --instance-ids ${awsid} --profile dev
}

function ssh-dev() {
  awshost=$( dev_instance_hostname )
  ssh -A -l ec2-user ${awshost}
}
