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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.4/stuurman_v0.11.0-rc.4_darwin_arm64.tar.gz"
      sha256 "d30a10aaee8dd8c7457551a926d8304ec5787d5e3a873034e6c49b48ca943bd1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.4/stuurman_v0.11.0-rc.4_linux_arm64.tar.gz"
      sha256 "de96e8998cf4b2a8068d5eb046b461ba4b70575cc944a2b059bf4c773537596a"
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
    assert_match "stuurman v0.11.0-rc.4", shell_output("#{bin}/stuurman-unstable version")
  end
end
