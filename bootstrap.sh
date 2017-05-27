#! /bin/dash

set -e # exit on errors

# htop is frivolous; if it's installed then we've run before
if ! dpkg -l | grep -q htop; then
   sudo apt-get update
   sudo apt-get upgrade
   sudo apt-get --no-install-recommends install \
      vim git zsh tmux \
      curl mtr tree htop
fi

# generate keys
if [ ! -e $HOME/.ssh/id_rsa ]; then
   ssh-keygen -t rsa -b 2048
   cat ~/.ssh/id_rsa.pub
   echo "\n\nGive me a GitHub 2FA token to add this to the keylist"
   echo "You'll need your GitHub password as well"
   echo "[blank] to add it yourself...\n\n"
   read otp
   if [ $otp ]; then
      curl -i -u wesQ3 \
         -H "X-GitHub-OTP: $otp" \
         -H "Content-Type: application/json" \
         --data "{\"title\":\"`cat /etc/hostname`-autogen\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" \
         https://api.github.com/user/keys
   else
      echo Press a key to continue
      read foo
   fi
fi

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
