# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the two SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  depends_on arch: :arm64

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.2/stuurman_v0.9.2_darwin_arm64.tar.gz"
      sha256 "abea1cd8e333fd7a1e80ac55487e981b949baea2d69d01067a6a9aaf1c37a2ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.2/stuurman_v0.9.2_linux_arm64.tar.gz"
      sha256 "4c6bd04a543f7cdf8ff5e78b949b1308f08c63f55e48255e545312db079f9d56"
    end
  end

  def install
    bin.install "stuurman"
  end

  def caveats
    <<~EOS
      Run stuurman install to start a Ship. Docker with Compose is needed.
    EOS
  end

  test do
    assert_match "stuurman v0.9.2", shell_output("#{bin}/stuurman version")
  end
end
