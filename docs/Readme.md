# Basic Env Setup

## Basic bashrc config

```sh
alias k=kubectl
alias kn="kubectl config set-context --current --namespace "
export do="--dry-run=client -o yaml"
export now="--force --grace-period=0"

source /etc/bash_completion
source <(kubectl completion bash)
complete -F __start_kubectl k
```

### basic vimrc

vim ~/.vimrc
```
colorscheme ron
set number
set showmatch

set hlsearch
set smartcase
set ignorecase
set incsearch

set expandtab
set tabstop=2
set shiftwidth=2
```

### Advance config
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh