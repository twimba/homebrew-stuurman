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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.12.0-rc.4/stuurman_v0.12.0-rc.4_darwin_arm64.tar.gz"
      sha256 "711c6678c64115392fb9a15882020f3b8d07e83bc7a855f739b1399341135d44"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.12.0-rc.4/stuurman_v0.12.0-rc.4_linux_arm64.tar.gz"
      sha256 "16e782f99d844db18dabc21e69e521cadcc56214d79655551cebbe846d03c0fd"
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
    assert_match "stuurman v0.12.0-rc.4", shell_output("#{bin}/stuurman-unstable version")
  end
end
