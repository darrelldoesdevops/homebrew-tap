# Formula/contentops.rb
#
# Sentinel system: Lines ending with === AUTO-UPDATE: <FIELD> === are patched
# automatically by the update-tap workflow in darrelldoesdevops/contentops.
# Do not remove sentinel comments or the auto-update script will fail.

class Contentops < Formula
  desc "Automated video content operations: silence removal, captions, overlays"
  homepage "https://github.com/darrelldoesdevops/contentops"
  # current version: 1.7.0 === AUTO-UPDATE: VERSION ===
  license "MIT"

  depends_on "ffmpeg"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/darrelldoesdevops/contentops/releases/download/v1.7.0/contentops-aarch64-apple-darwin" # === AUTO-UPDATE: ARM-URL ===
      sha256 "90fe6ecfe2a4210828cb42981f47ebfa5539a9d82b1c61bafda509deac1405a9" # === AUTO-UPDATE: ARM-SHA256 ===
    end

    on_intel do
      url "https://github.com/darrelldoesdevops/contentops/releases/download/v1.7.0/contentops-x86_64-apple-darwin" # === AUTO-UPDATE: INTEL-URL ===
      sha256 "a77fbc132963ab90faf23e1a44bbe80344c71dbeaae5f9c3f2ef8d4274040e25" # === AUTO-UPDATE: INTEL-SHA256 ===
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "contentops-aarch64-apple-darwin" => "contentops"
    else
      bin.install "contentops-x86_64-apple-darwin" => "contentops"
    end
  end

  def caveats
    <<~EOS
      contentops requires the following:

        whisper-cli (not a Homebrew package):
          https://github.com/ggml-org/whisper.cpp
          A whisper model file is also required — see the whisper.cpp docs.

        Claude CLI (optional, for AI-powered caption generation):
          https://claude.ai/download

      FFmpeg is installed automatically as a dependency.

      Run `contentops doctor` to check your environment.
    EOS
  end

  test do
    assert_match "Video processing pipeline", shell_output("#{bin}/contentops --help")
  end
end
