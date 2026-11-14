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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.2/stuurman_v0.11.0-rc.2_darwin_arm64.tar.gz"
      sha256 "158673bb6860acde2597a6de1394f1be7f88532d54e79804efad6ebc0dbec379"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.2/stuurman_v0.11.0-rc.2_linux_arm64.tar.gz"
      sha256 "043998bd6ddbdcccec5a9d0758f9b014c5cead40eb6fd32f98740a92aeaf2fa0"
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
    assert_match "stuurman v0.11.0-rc.2", shell_output("#{bin}/stuurman-unstable version")
  end
end
