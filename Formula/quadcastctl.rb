class Quadcastctl < Formula
  desc "Native Rust controller for HyperX Quadcast S RGB lights"
  homepage "https://github.com/miketineo/quadcastctl"
  url "https://github.com/miketineo/quadcastctl/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "6889f82780eadc1920983d62d25c6fe77ea006a1dc786a23dc6235e1537e8459"
  license "GPL-2.0-only"
  head "https://github.com/miketineo/quadcastctl.git", branch: "main"

  depends_on "rust" => :build
  depends_on "libusb"

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      🎙️  quadcastctl installed. Three ways to set a color:

        1. Pop the macOS system color picker:

               quadcastctl pick

        2. Use a named preset (try `quadcastctl preset list` for the full set):

               quadcastctl set hivenet
               quadcastctl set off

        3. Set a raw hex color:

               quadcastctl set ff9a33 -b 60

      Then install the launchd LaunchAgent so the daemon runs at login
      and the color persists across reboots:

               quadcastctl install

      Other commands: show, status, start, stop, restart, uninstall.

      The first run may print a benign warning about claiming USB
      interface 1 — that is macOS's HID kernel driver holding the
      interface and is expected. The control transfer still works.

      Docs: https://github.com/miketineo/quadcastctl
    EOS
  end

  test do
    assert_match "quadcastctl", shell_output("#{bin}/quadcastctl --version")
    assert_match "Usage:", shell_output("#{bin}/quadcastctl --help")
  end
end
