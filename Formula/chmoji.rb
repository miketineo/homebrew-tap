class Chmoji < Formula
  desc ":shortcode: emoji expansion and picker for zsh, Vim, and Neovim"
  homepage "https://github.com/miketineo/chmoji"
  url "https://github.com/miketineo/chmoji/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "27b4895dd17ad3d1c6a3c792eee58973b74e7bf150456dd5830aa40ff7e43202"
  license "MIT"
  head "https://github.com/miketineo/chmoji.git", branch: "main"

  depends_on "fzf"

  def install
    pkgshare.install "chmoji.plugin.zsh"
    (share/"chmoji-vim").install "plugin", "autoload", "doc", "lua"
  end

  def caveats
    <<~EOS
      chmoji installed. To activate:

      ── zsh ──────────────────────────────────────────────────────────────────
      Add to ~/.zshrc (after oh-my-zsh's `emoji` plugin, before
      zsh-syntax-highlighting if you use it):

          source "$(brew --prefix chmoji)/share/chmoji/chmoji.plugin.zsh"

      Smoke test in a new shell:   echo :tada:   →   echo 🎉

      ── Vim / Neovim ─────────────────────────────────────────────────────────
      Plugin managers (recommended — pick one):

          Plug 'miketineo/chmoji'                        " vim-plug
          use 'miketineo/chmoji'                         " packer
          { 'miketineo/chmoji' }                         -- lazy.nvim

      Or point your runtimepath at the Homebrew-installed runtime:

          set runtimepath+=$(brew --prefix chmoji)/share/chmoji-vim
          silent! helptags ALL

      In insert mode:  :tada:  →  🎉   ·   <C-x>e  opens the emoji picker.
      From normal mode: :Chmoji [query]   ·   :Chmoji disable / enable / toggle

      ── requirements ─────────────────────────────────────────────────────────
      zsh side requires oh-my-zsh's `emoji` plugin (~4200 shortcodes):
      https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/emoji

      Docs: https://github.com/miketineo/chmoji
    EOS
  end

  test do
    system "zsh", "-n", "#{pkgshare}/chmoji.plugin.zsh"
    assert_predicate share/"chmoji-vim/plugin/chmoji.vim", :exist?
  end
end
