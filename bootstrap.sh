#! /bin/dash

set -e # exit on errors

# install packages
sudo apt-get update
sudo apt-get upgrade
sudo apt-get --no-install-recommends install \
   vim git zsh tmux \
   curl mtr tree htop

# generate keys
if [ ! -e $HOME/.ssh/id_rsa ]; then
   ssh-keygen -t rsa -b 2048
fi
echo "\n\nAdd this thing to github allowed keys\nhttps://github.com/settings/keys\n\n"
cat ~/.ssh/id_rsa.pub
echo "\n"
read foo

# plenv
if [ ! -d $HOME/.plenv ]; then
   git clone https://github.com/tokuhirom/plenv.git ~/.plenv
   git clone https://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/
fi

# homeshick
if [ ! -d $HOME/.homesick ]; then
   git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi

# ohmyzsh
# sh -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
[ ! -d $HOME/.oh-my-zsh ] && \
   git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

HS=$HOME/.homesick/repos/homeshick/bin/homeshick
[ ! -d $HOME/.homesick/repos/dotfiles ] && \
   $HS clone --batch git@github.com:wesQ3/dotfiles.git
$HS link --force

# fonts
$HS clone --batch git@github.com:wesQ3/powerline-fonts-wes.git
$HS cd powerline-fonts-wes
./install.sh
cd $HOME

chsh --shell /bin/zsh

# vim
[ ! -d $HOME/.vim/bundle/Vundle.vim ] && \
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir -p $HOME/.vim/undo
mkdir -p $HOME/.vim/swap
