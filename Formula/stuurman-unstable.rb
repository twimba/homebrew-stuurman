# The Homebrew formula of stuurman-unstable: the stuurman command installed
# under the name that makes it follow release candidates as well as releases.
# It is written for each release candidate and each release newer than the
# last one from a template (the tag and the four SHA-256 values are filled
# in); a change made here by hand is lost with the next one. Homebrew reads
# the version from the urls.
class StuurmanUnstable < Formula
  desc "Command that installs and runs a Ship, release candidates included"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.3/stuurman_v0.9.0-rc.3_darwin_arm64.tar.gz"
      sha256 "49da6144ac8ca7809c2d5764247e6b9eb4eb569d68c8eee7bac365e5b3544866"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.3/stuurman_v0.9.0-rc.3_darwin_amd64.tar.gz"
      sha256 "6cb90788345c367d7acb978a5726b7f2fac69ab3e67ca5e1d49e9312a482040b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.3/stuurman_v0.9.0-rc.3_linux_arm64.tar.gz"
      sha256 "fd1642248c40e613fa7801fcf24fc9bfd3e6d5c024e217c9f81fdbbce9d2a742"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.3/stuurman_v0.9.0-rc.3_linux_amd64.tar.gz"
      sha256 "51f124804341779a1f15a76d1204c7beb8dd0f4ff7071a8cafef11740a1f0136"
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
    assert_match "stuurman v0.9.0-rc.3", shell_output("#{bin}/stuurman-unstable version")
  end
end
