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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.12.0-rc.10/stuurman_v0.12.0-rc.10_darwin_arm64.tar.gz"
      sha256 "7c7463449bc20185fe54d0da969d956abd8eae88f3355fc9cdbd91398c3f86b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.12.0-rc.10/stuurman_v0.12.0-rc.10_linux_arm64.tar.gz"
      sha256 "af8fdfb10eaed7ac634d62e827da6dca47b9cf516c7fe416e26dc1c951bd873e"
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
    assert_match "stuurman v0.12.0-rc.10", shell_output("#{bin}/stuurman-unstable version")
  end
end
