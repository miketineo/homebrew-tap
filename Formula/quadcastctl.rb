class Quadcastctl < Formula
  desc "Native Rust controller for HyperX Quadcast S RGB lights"
  homepage "https://github.com/miketineo/quadcastctl"
  url "https://github.com/miketineo/quadcastctl/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "6e05aac8ce315235198443b49f6cef401c8931533b5b0fdccfff41dc4b910689"
  license "GPL-2.0-only"
  head "https://github.com/miketineo/quadcastctl.git", branch: "main"

  depends_on "rust" => :build
  depends_on "libusb"

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      🎙️  quadcastctl installed. Quick start:

        quadcastctl pick                            # macOS color picker
        quadcastctl set hivenet                     # named preset
        quadcastctl set ff9a33 -b 60                # hex + brightness

      Motion modes (hot-reload while the daemon runs):

        quadcastctl set cycle red green blue        # smooth gradient cycle
        quadcastctl set wave  red orange yellow     # cycle, diodes out of phase
        quadcastctl set pulse hivenet               # breathing fade in/out
        quadcastctl set lightning ff0000            # flash + fade
        quadcastctl set blink red blue              # hard switching
        # tune motion with --speed 0..100 and --delay 0..100

      Persist across reboots by installing the launchd LaunchAgent:

        quadcastctl install

      Other commands: show, status, start, stop, restart, uninstall,
      preset list, preset add NAME HEX, preset remove NAME.

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
