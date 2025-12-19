# Dotfiles

Personal macOS development environment configuration files.

This repository contains my carefully curated dotfiles for a modern, efficient terminal-based development workflow featuring Ghostty terminal, Neovim with LazyVim, tmux, and a customized zsh setup.

## Features

- **Modern Terminal**: Ghostty terminal with optimized settings
- **Powerful Editor**: Neovim configured with LazyVim for an IDE-like experience
- **Terminal Multiplexer**: tmux with system monitoring (CPU/RAM) and custom keybindings
- **Beautiful Shell**: zsh with powerlevel10k theme and fzf integration
- **Consistent Git**: Standardized git configuration
- **Custom Font**: psudoFont Liga Mono with programming ligatures

## Contents

```
dotfiles/
├── ghostty/       # Ghostty terminal configuration
├── tmux/          # tmux configuration with system monitoring
├── nvim/          # Neovim (LazyVim) setup with custom plugins
├── shell/         # zsh configs (.zshrc, .zshenv, powerlevel10k, fzf)
└── git/           # git configuration
```

## Prerequisites

Before setting up these dotfiles, install the following:

### Essential Tools

```bash
# Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core utilities
brew install git neovim tmux fzf ripgrep fd

# Ghostty terminal
brew install --cask ghostty

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Fonts

Install [psudoFont Liga Mono](https://github.com/psudo-dev/psudofont-liga-mono):
```bash
brew tap homebrew/cask-fonts
brew install --cask font-psudofont-liga-mono
```

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/katzio/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Backup existing configs (optional but recommended)

```bash
# Backup existing dotfiles
mkdir -p ~/dotfiles-backup
mv ~/.zshrc ~/dotfiles-backup/ 2>/dev/null
mv ~/.zshenv ~/dotfiles-backup/ 2>/dev/null
mv ~/.p10k.zsh ~/dotfiles-backup/ 2>/dev/null
mv ~/.gitconfig ~/dotfiles-backup/ 2>/dev/null
mv ~/.config/nvim ~/dotfiles-backup/ 2>/dev/null
mv ~/.config/tmux ~/dotfiles-backup/ 2>/dev/null
```

### 3. Create symlinks

```bash
# Set the dotfiles directory (adjust if you cloned elsewhere)
DOTFILES="$HOME/.dotfiles"

# Ghostty - Find config directory with: osascript -e 'tell application "Finder" to POSIX path of (get folder of (path to application id "com.mitchellh.ghostty") as alias)'
# Typical location: ~/Library/Application Support/com.mitchellh.ghostty/
# The config file should be at: ~/Library/Application Support/com.mitchellh.ghostty/config
GHOSTTY_CONFIG="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_CONFIG"
ln -sf "$DOTFILES/ghostty/config" "$GHOSTTY_CONFIG/config"

# tmux
mkdir -p ~/.config/tmux
ln -sf "$DOTFILES/tmux/tmux.conf" ~/.config/tmux/tmux.conf
ln -sf "$DOTFILES/tmux/tmux.conf" ~/.tmux.conf

# nvim
ln -sf "$DOTFILES/nvim" ~/.config/nvim

# shell
ln -sf "$DOTFILES/shell/zshrc" ~/.zshrc
ln -sf "$DOTFILES/shell/zshenv" ~/.zshenv
ln -sf "$DOTFILES/shell/p10k.zsh" ~/.p10k.zsh
ln -sf "$DOTFILES/shell/fzf.zsh" ~/.fzf.zsh

# git (customize with your own name/email first!)
ln -sf "$DOTFILES/git/gitconfig" ~/.gitconfig
```

**Note for LLMs**: To find the Ghostty config directory dynamically, check:
1. `~/Library/Application Support/com.mitchellh.ghostty/` (standard location)
2. Use `mdfind -name ghostty | grep -i "application support"` to search
3. Check Ghostty's documentation or run `ghostty --help` for config path info

### 4. Install plugins and reload

```bash
# Reload shell configuration
source ~/.zshrc

# Open tmux and install plugins (press prefix + I)
tmux
# Inside tmux: Ctrl+Space then Shift+I

# Open Neovim to trigger LazyVim installation
nvim
```

## Customization

### Git Configuration

Before using the git config, update it with your own information:

```bash
# Edit git/gitconfig
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Shell Customization

- Modify `shell/zshrc` for custom aliases and functions
- Run `p10k configure` to customize the powerlevel10k theme
- Edit `shell/fzf.zsh` for fzf keybindings and options

## Key Features

### Neovim

- LazyVim configuration with custom plugins
- LSP support for multiple languages
- Debugging with DAP
- Git integration with LazyGit
- File tree with Neo-tree
- Fuzzy finding with fzf

### tmux

- CPU and RAM monitoring in status bar
- Custom keybindings for productivity
- Plugin management with TPM

### Shell

- Powerlevel10k theme for a beautiful prompt
- fzf integration for fuzzy file finding
- Custom aliases and functions

## Troubleshooting

### Fonts not showing correctly

Make sure psudoFont Liga Mono is installed and selected in your terminal settings.

### tmux plugins not loading

1. Ensure TPM is installed: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
2. Press `prefix + I` (Ctrl+Space then Shift+I) inside tmux to install plugins

### Neovim plugins not loading

Open Neovim and run `:Lazy sync` to install/update all plugins.

## Acknowledgments

- [LazyVim](https://www.lazyvim.org/) - Amazing Neovim configuration
- [Ghostty](https://ghostty.org/) - Fast, native terminal emulator
- [powerlevel10k](https://github.com/romkatv/powerlevel10k) - Beautiful zsh theme
- [psudoFont Liga Mono](https://github.com/psudo-dev/psudofont-liga-mono) - Excellent programming font

## License

This project is open source and available under the [MIT License](LICENSE).

## Contact

Feel free to open an issue or submit a pull request if you have suggestions for improvements!
