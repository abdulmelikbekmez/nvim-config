# Neovim Config

## Dependencies

### Must!
Make sure that this tools installed on your machine.

- [fd](https://github.com/sharkdp/fd)  - for searching file from filesystem 
```
cargo install fd-find
```
- [ripgrep](https://github.com/BurntSushi/ripgrep) - for searching word or patterns from your workspace.

```
cargo install ripgrep
```


### Optional
- Nodejs - for Language Server Protocols (pyright ex.)
## Installation

Make sure to remove or move your current `nvim` directory

**IMPORTANT** requires `Neovim 0.8 release` version
```
git clone https://github.com/abdulmelikbekmez/nvim-config.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed 

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim) 

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```
  sudo apt install xsel
  ```

- On Arch Linux

  ```
  sudo pacman -S xsel
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```
  pip install pynvim
  ```

- Neovim node support

  ```
  npm i -g neovim
  ```
---

## Debugging

# Python

To debug python apps you need to instal debugpy. You can install debugpy with mason plugin.
To open mason press SPACE+l+I , search for python with  CTRL+f and install debugpy.

**NOTE** make sure you have [node](https://nodejs.org/en/) installed, I recommend a node manager like [fnm](https://github.com/Schniz/fnm).

> The computing scientist's main challenge is not to get confused by the complexities of his own making. 

\- Edsger W. Dijkstra
