class Quadcastctl < Formula
  desc "Native Rust controller for HyperX Quadcast S RGB lights"
  homepage "https://github.com/miketineo/quadcastctl"
  url "https://github.com/miketineo/quadcastctl/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "bf46c0a5356fd7c2ee321bf5d2246aa2329daec5ceeae1bb53feb2eebc3382d7"
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

      Mute integration (system-level mute only — the QuadCast's hardware
      tap-to-mute is invisible to macOS, so these features only fire on
      Control Center mute, app-level mute, or `quadcastctl mute`):

        quadcastctl mute-color red                  # color shown when muted
        quadcastctl mute / unmute / mute-toggle     # drive Core Audio mute
        quadcastctl audio-state                     # watch the mute property

      Google Meet sync (NEW in 0.5.0 — clicks Meet's mic button on every
      system-mute transition; requires Chrome > View > Developer >
      "Allow JavaScript from Apple Events"):

        quadcastctl meet-sync on

      Persist across reboots by installing the launchd LaunchAgent:

        quadcastctl install

      Other commands: show, status, start, stop, restart, uninstall,
      preset list, preset add NAME HEX, preset remove NAME, audio-debug.

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
