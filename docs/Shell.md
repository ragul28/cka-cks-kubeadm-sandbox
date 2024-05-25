# Basic Env Setup

## Basic bashrc config

```sh
alias k=kubectl
alias kk=kubectl
alias kd="kubectl describe"
alias ks="kubectl -n kube-system"
export d=" --dry-run=client -o yaml"

source /etc/bash_completion
source <(kubectl completion bash)
complete -F __start_kubectl k
```

### basic vimrc

vim ~/.vimrc
```
set number
set expandtab
set tabstop=2
set shiftwidth=2
```

### Advance config
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh