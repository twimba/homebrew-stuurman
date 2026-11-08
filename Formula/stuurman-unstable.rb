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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.10.0-rc.7/stuurman_v0.10.0-rc.7_darwin_arm64.tar.gz"
      sha256 "35d0e13548928f47ec99e725d1b4a5dc6bcbe4de63099af8eb8b8712a5e467b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.10.0-rc.7/stuurman_v0.10.0-rc.7_linux_arm64.tar.gz"
      sha256 "8ecef1857c43555ab31601bc915dd59742d1f3a3bd8a4597e0331c4bec5f1a2c"
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
    assert_match "stuurman v0.10.0-rc.7", shell_output("#{bin}/stuurman-unstable version")
  end
end
