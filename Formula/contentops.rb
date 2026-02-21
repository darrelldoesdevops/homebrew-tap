# Formula/contentops.rb
#
# Sentinel system: Lines ending with === AUTO-UPDATE: <FIELD> === are patched
# automatically by the update-tap workflow in darrelldoesdevops/contentops.
# Do not remove sentinel comments or the auto-update script will fail.

class Contentops < Formula
  desc "Automated video content operations: silence removal, captions, overlays"
  homepage "https://github.com/darrelldoesdevops/contentops"
  # current version: 1.2.0 === AUTO-UPDATE: VERSION ===
  license "MIT"

  depends_on "ffmpeg"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/darrelldoesdevops/contentops/releases/download/v1.2.0/contentops-aarch64-apple-darwin" # === AUTO-UPDATE: ARM-URL ===
      sha256 "ec58e2d8106c84de25ae20641a060cbf85a91bb7cab4f0f60f27577f8333f0ba" # === AUTO-UPDATE: ARM-SHA256 ===
    end

    on_intel do
      url "https://github.com/darrelldoesdevops/contentops/releases/download/v1.2.0/contentops-x86_64-apple-darwin" # === AUTO-UPDATE: INTEL-URL ===
      sha256 "7b458789bc33664820bccaddaf023828133b6a29ab8e4a7b61d5b91dd18fa560" # === AUTO-UPDATE: INTEL-SHA256 ===
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
