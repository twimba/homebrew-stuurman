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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.10.0-rc.3/stuurman_v0.10.0-rc.3_darwin_arm64.tar.gz"
      sha256 "71c65a8e1f6c1778e909ddb43a9888b82c8612ffdd2777252717d7fbe48008b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.10.0-rc.3/stuurman_v0.10.0-rc.3_linux_arm64.tar.gz"
      sha256 "dc340b72ad635a2126feeccd8a110cf92361c6d0e2e8c97a4bf4ea298c3643fe"
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
    assert_match "stuurman v0.10.0-rc.3", shell_output("#{bin}/stuurman-unstable version")
  end
end
