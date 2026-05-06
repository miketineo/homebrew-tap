class Quadcastctl < Formula
  desc "Native Rust controller for HyperX Quadcast S RGB lights"
  homepage "https://github.com/miketineo/quadcastctl"
  url "https://github.com/miketineo/quadcastctl/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "087a0edc2fb4d6c87e68a4080fa565171eec6e61ff20cb4b055674c7f7288454"
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

      Mute integration (NEW in 0.4.0):

        quadcastctl mute-color red                  # LED turns red whenever muted
        quadcastctl mute / unmute / mute-toggle     # software-control input mute
        quadcastctl audio-state                     # diagnostic: list inputs, watch mute

      The hardware tap-to-mute on the Quadcast forwards to macOS's
      input mute property, so the LED reacts to physical taps and to
      software mutes (Control Center, Zoom, FaceTime, anything that
      respects system mute) with the same ~1s latency.

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
