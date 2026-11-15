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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.6/stuurman_v0.11.0-rc.6_darwin_arm64.tar.gz"
      sha256 "25c33db7f578fe8a9e1ed7faaa9d833b4325ffb8b7d6b15e1187526efff3ae41"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.6/stuurman_v0.11.0-rc.6_linux_arm64.tar.gz"
      sha256 "cc978cc638f302d6f1c28df888430831bc83da39d8c953426355241c888840fe"
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
    assert_match "stuurman v0.11.0-rc.6", shell_output("#{bin}/stuurman-unstable version")
  end
end
