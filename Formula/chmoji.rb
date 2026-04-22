class Chmoji < Formula
  desc ":shortcode: emoji expansion and auto-popup picker for zsh"
  homepage "https://github.com/miketineo/chmoji"
  url "https://github.com/miketineo/chmoji/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "fde487154106783d35e6e4a0bb274c8ef15d8f4998af367a4eb5bbb7773ee8c9"
  license "MIT"
  head "https://github.com/miketineo/chmoji.git", branch: "main"

  depends_on "fzf"

  def install
    pkgshare.install "chmoji.plugin.zsh"
  end

  def caveats
    <<~EOS
      🎉 chmoji installed. Two steps to activate:

        1. Add this line to ~/.zshrc — after oh-my-zsh's `emoji` plugin
           (or any other source of $emoji) and before zsh-syntax-highlighting
           if you use it:

               source "$(brew --prefix chmoji)/share/chmoji/chmoji.plugin.zsh"

        2. Open a new shell and smoke-test:

               echo :tada:
               ❯ echo 🎉   ← the closing colon triggers the expansion

      Requires oh-my-zsh's `emoji` plugin for $emoji (~4200 shortcodes):
      https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/emoji

      Docs: https://github.com/miketineo/chmoji
    EOS
  end

  test do
    system "zsh", "-n", "#{pkgshare}/chmoji.plugin.zsh"
  end
end
