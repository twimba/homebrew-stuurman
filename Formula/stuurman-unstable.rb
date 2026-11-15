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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.8/stuurman_v0.11.0-rc.8_darwin_arm64.tar.gz"
      sha256 "47cd95255cbc17e102fa5b62192174a43de5f04f4e5df31a9f0e761e5c858c6d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.8/stuurman_v0.11.0-rc.8_linux_arm64.tar.gz"
      sha256 "7cd22421a9d600fea6a73a6aa4b1c0761a0905d404051151ec919f93abca5d84"
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
    assert_match "stuurman v0.11.0-rc.8", shell_output("#{bin}/stuurman-unstable version")
  end
end
