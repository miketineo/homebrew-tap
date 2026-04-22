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
      To activate chmoji, add this to your ~/.zshrc — after oh-my-zsh's
      `emoji` plugin is loaded (so $emoji is populated) and before
      zsh-syntax-highlighting (which must stay last):

          source #{opt_pkgshare}/chmoji.plugin.zsh

      chmoji reuses oh-my-zsh's `emoji` plugin for its ~4200 shortcodes.
      If you don't run oh-my-zsh, you can define $emoji yourself. See:
      https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/emoji
    EOS
  end

  test do
    system "zsh", "-n", "#{pkgshare}/chmoji.plugin.zsh"
  end
end
