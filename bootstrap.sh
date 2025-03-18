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
sshkey=$HOME/.ssh/id_ed25519
if [ ! -e $sshkey ]; then
   ssh-keygen -t ed25519
   cat $sshkey.pub
   echo "\n\nGive me a GitHub 2FA token to add this to the keylist"
   echo "You'll need your GitHub password as well"
   echo "[blank] to add it yourself...\n\n"
   read otp
   if [ $otp ]; then
      curl -i -u wesQ3 \
         -H "X-GitHub-OTP: $otp" \
         -H "Content-Type: application/json" \
         --data "{\"title\":\"`cat /etc/hostname`-autogen\",\"key\":\"`cat $sshkey.pub`\"}" \
         https://api.github.com/user/keys
   else
      echo Press a key to continue
      read foo
   fi
fi

# diff-so-fancy diff viewer
if [ ! -d /usr/local/diff-so-fancy ]; then
   sudo git clone https://github.com/so-fancy/diff-so-fancy.git /usr/local/diff-so-fancy
   sudo ln -s /usr/local/diff-so-fancy/diff-so-fancy /usr/local/bin/diff-so-fancy
fi

# plenv
if [ ! -d $HOME/.plenv ]; then
   git clone https://github.com/tokuhirom/plenv.git ~/.plenv
   git clone https://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/
fi

# homeshick
if [ ! -d $HOME/.homesick ]; then
   git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi

# ohmyzsh
# sh -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
[ ! -d $HOME/.oh-my-zsh ] && \
   git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

HS=$HOME/.homesick/repos/homeshick/bin/homeshick
[ ! -d $HOME/.homesick/repos/dotfiles ] && \
   $HS clone --batch git@github.com:wesQ3/dotfiles.git
$HS link --force

# fzf fuzzy finding
[ ! -f ~/.fzf.zsh ] && \
   git clone https://github.com/junegunn/fzf.git $HOME/.fzf && \
   $HOME/.fzf/install --no-update-rc

# fonts
echo "Install fonts? [blank] to skip:"
read font
if [ $font ]; then
   $HS clone --batch git@github.com:wesQ3/powerline-fonts-wes.git
   $HS cd powerline-fonts-wes
   ./install.sh
fi

cd $HOME

echo Setting local shell
chsh --shell /bin/zsh

# vim
vimdir=$HOME/.vim
mkdir -p $vimdir/undo
mkdir -p $vimdir/swap
mkdir -p $vimdir/autoload
if [ ! -d $vimdir/bundle/vim-plug ]; then
   git clone https://github.com/junegunn/vim-plug.git $vimdir/bundle/vim-plug
   ln -s $vimdir/bundle/vim-plug/plug.vim $vimdir/autoload/plug.vim
fi

# starship prompt
if ! command -v starship >/dev/null 2>&1; then
   echo "Install starship prompt"
   TMP_DIR=$(mktemp -d)
   curl -sL "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz"\
      -o "$TMP_DIR/starship.tar.gz"
   tar -xvf "$TMP_DIR/starship.tar.gz" -C "$TMP_DIR"
   sudo mv "$TMP_DIR/starship" /usr/local/bin/
   rm -rf "$TMP_DIR"

   echo "Starship installation complete."
fi
