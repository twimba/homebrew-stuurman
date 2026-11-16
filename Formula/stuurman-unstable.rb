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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.12/stuurman_v0.11.0-rc.12_darwin_arm64.tar.gz"
      sha256 "72298cbf1334d0e5a6d2dba6a28560d13028709daa27fd0a514d54e067f46fec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.12/stuurman_v0.11.0-rc.12_linux_arm64.tar.gz"
      sha256 "1abe41b9f811f18ffe790708a3f1df118f4bc61a512777f54dded3ee3186f1e3"
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
    assert_match "stuurman v0.11.0-rc.12", shell_output("#{bin}/stuurman-unstable version")
  end
end
