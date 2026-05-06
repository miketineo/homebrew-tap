class Quadcastctl < Formula
  desc "Native Rust controller for HyperX Quadcast S RGB lights"
  homepage "https://github.com/miketineo/quadcastctl"
  url "https://github.com/miketineo/quadcastctl/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "cc365b2edbefc3f97dcf6ce4bf3e4812f836baaa1a0eb96ef4f0fb5a6f346bbc"
  license "GPL-2.0-only"
  head "https://github.com/miketineo/quadcastctl.git", branch: "main"

  depends_on "rust" => :build
  depends_on "libusb"

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      🎙️  quadcastctl installed. Three steps to RGB control:

        1. Pick a color (uses the macOS system color picker — coming soon)
           or set one directly:

               quadcastctl set ff9a33

        2. Install the launchd LaunchAgent so the daemon runs at login
           and the lights persist across reboots:

               quadcastctl install

        3. Change the color anytime with:

               quadcastctl set <hex> [-b BRIGHTNESS]
               quadcastctl show
               quadcastctl status

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
