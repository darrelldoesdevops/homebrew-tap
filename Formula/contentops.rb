# Formula/contentops.rb
#
# Sentinel system: Lines ending with === AUTO-UPDATE: <FIELD> === are patched
# automatically by the update-tap workflow in darrelldoesdevops/contentops.
# Do not remove sentinel comments or the auto-update script will fail.

class Contentops < Formula
  desc "Automated video content operations: silence removal, captions, overlays"
  homepage "https://github.com/darrelldoesdevops/contentops"
  # current version: 1.3.2 === AUTO-UPDATE: VERSION ===
  license "MIT"

  depends_on "ffmpeg"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/darrelldoesdevops/contentops/releases/download/v1.3.2/contentops-aarch64-apple-darwin" # === AUTO-UPDATE: ARM-URL ===
      sha256 "e03f20001f8b47b23602993d69735496bc83e96914de78fccca4f7caf7007840" # === AUTO-UPDATE: ARM-SHA256 ===
    end

    on_intel do
      url "https://github.com/darrelldoesdevops/contentops/releases/download/v1.3.2/contentops-x86_64-apple-darwin" # === AUTO-UPDATE: INTEL-URL ===
      sha256 "d49f87a225d7133cefdf8ec18b3ab786b0545c37aa72fcbda5c676a6595a740c" # === AUTO-UPDATE: INTEL-SHA256 ===
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
