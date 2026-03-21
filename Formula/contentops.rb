# Formula/contentops.rb
#
# Sentinel system: Lines ending with === AUTO-UPDATE: <FIELD> === are patched
# automatically by the update-tap workflow in darrelldoesdevops/contentops.
# Do not remove sentinel comments or the auto-update script will fail.

class Contentops < Formula
  desc "Automated video content operations: silence removal, captions, overlays"
  homepage "https://github.com/darrelldoesdevops/contentops"
  # current version: 1.6.0 === AUTO-UPDATE: VERSION ===
  license "MIT"

  depends_on "ffmpeg"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/darrelldoesdevops/contentops/releases/download/v1.6.0/contentops-aarch64-apple-darwin" # === AUTO-UPDATE: ARM-URL ===
      sha256 "a34d86c0f56289115d1331c8b039165127d5048c9e82750f276458598cc42cd1" # === AUTO-UPDATE: ARM-SHA256 ===
    end

    on_intel do
      url "https://github.com/darrelldoesdevops/contentops/releases/download/v1.6.0/contentops-x86_64-apple-darwin" # === AUTO-UPDATE: INTEL-URL ===
      sha256 "85da4cb4190de1309c9e29a6b4a87732751de5d558b9aefad9219265296495fe" # === AUTO-UPDATE: INTEL-SHA256 ===
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
