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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.7/stuurman_v0.9.0-rc.7_darwin_arm64.tar.gz"
      sha256 "2593a62bcf42670515ac23370854f4df33aa3d9440c537a7641f55b56a6dbfb3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.7/stuurman_v0.9.0-rc.7_linux_arm64.tar.gz"
      sha256 "caef73fc10aea4abd8b0437e985ccd388af2b5701b18d76b85112834f78237c7"
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
    assert_match "stuurman v0.9.0-rc.7", shell_output("#{bin}/stuurman-unstable version")
  end
end
