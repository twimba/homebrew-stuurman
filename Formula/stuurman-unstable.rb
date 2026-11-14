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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.3/stuurman_v0.11.0-rc.3_darwin_arm64.tar.gz"
      sha256 "02640c180d84503cb3ad301360bc8349f1179c064009eba9a5b3512536b5ebf7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.3/stuurman_v0.11.0-rc.3_linux_arm64.tar.gz"
      sha256 "20b04f28c6770850086f7e91262272fc1ff33d9ad0a5fcc28aff513df0117941"
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
    assert_match "stuurman v0.11.0-rc.3", shell_output("#{bin}/stuurman-unstable version")
  end
end
