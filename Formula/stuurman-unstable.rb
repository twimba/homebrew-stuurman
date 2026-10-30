# The Homebrew formula of stuurman-unstable: the stuurman command installed
# under the name that makes it follow release candidates as well as releases.
# It is written for each release candidate and each release newer than the
# last one from a template (the tag and the two SHA-256 values are filled
# in); a change made here by hand is lost with the next one. Homebrew reads
# the version from the urls.
class StuurmanUnstable < Formula
  desc "Command that installs and runs a Ship, release candidates included"
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
    bin.install "stuurman" => "stuurman-unstable"
  end

  def caveats
    <<~EOS
      Run stuurman-unstable install to start a Ship that follows release
      candidates. Docker with Compose is needed.
    EOS
  end

  test do
    assert_match "stuurman v0.9.0", shell_output("#{bin}/stuurman-unstable version")
  end
end
