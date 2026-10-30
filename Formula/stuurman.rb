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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0/stuurman_v0.9.0_darwin_arm64.tar.gz"
      sha256 "b22291a61069da3494a6014d63f10d3c517ca335143a5d94cc18bf5b1e74b21d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0/stuurman_v0.9.0_linux_arm64.tar.gz"
      sha256 "43bf9cdeaef08c188058eeb56e5ba4732de130f62e7b6606b396963b8833e4fa"
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
    assert_match "stuurman v0.9.0", shell_output("#{bin}/stuurman version")
  end
end
