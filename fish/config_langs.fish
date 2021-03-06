# direnv
if type direnv > /dev/null 2>&1
  eval (direnv hook fish)
end

# golang
if type go > /dev/null 2>&1
  set -x GO111MODULE on
  set -x GOPATH "$HOME/repos"
  set -x PATH $PATH "$GOPATH/bin"
  if [ -e "$GOPATH" ]
    mkdir "$GOPATH"
  end
end

if [ -e "$HOME/.goenv" ]
  set -x GOENV_ROOT $HOME/.goenv
  set -x PATH $GOENV_ROOT/bin $PATH
  eval (goenv init - --no-rehash | source)
end

# python
if [ -e "$HOME/.pyenv" ]
  set -x PYENV_ROOT "$HOME/.pyenv"
  set -x PATH $HOME/.pyenv/shims $PATH
  eval (pyenv init - --no-rehash | source)
end

# ruby
if [ -e "$HOME/.rbenv" ]
  set -x RBENV_ROOT $HOME/.rbenv
  set -x PATH $RBENV_ROOT/bin $PATH
  source (rbenv init - --no-rehash| psub)
end

# node
if [ -e "$HOME/.nodenv" ]
  set -Ux fish_user_paths $HOME/.nodenv/bin $fish_user_paths
  eval (nodenv init - | source)
end

# rust
if [ -e "$HOME/.cargo" ]
  set -x PATH "$HOME/.cargo/bin" $PATH
end

# java
if [ -e "$HOME/.jenv" ]
  set -x  PATH $HOME/.jenv/bin $PATH
  eval (jenv init - | source)
  eval (jenv enable-plugin export | source)
  jenv add (/usr/libexec/java_home) > /dev/null &
end
