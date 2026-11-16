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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0/stuurman_v0.11.0_darwin_arm64.tar.gz"
      sha256 "282c55282b893d21a5f5f65caa6b527e078fc50edafc7c38b2b3959e8c3f91ee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0/stuurman_v0.11.0_linux_arm64.tar.gz"
      sha256 "acf0d3f57856ad2b6ec145137d17d29264ed8d64631d66755247d0bb973cbf7a"
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
    assert_match "stuurman v0.11.0", shell_output("#{bin}/stuurman-unstable version")
  end
end
