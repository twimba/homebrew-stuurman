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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.5/stuurman_v0.9.0-rc.5_darwin_arm64.tar.gz"
      sha256 "9aec8e5a02abd63c59cc1963230e6f092f953b4bf7d03eb5da4f333c59be9bab"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.5/stuurman_v0.9.0-rc.5_darwin_amd64.tar.gz"
      sha256 "4aff2d826314fdf6444e30761031f26a8cf3e4cf9f3bcf1fee67c4e9ed52d25c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.5/stuurman_v0.9.0-rc.5_linux_arm64.tar.gz"
      sha256 "9b989b53a28aa8d18c39fb8b5369fe4f03f4e18f95c8c732ddc7b3d8a45bbe8f"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.5/stuurman_v0.9.0-rc.5_linux_amd64.tar.gz"
      sha256 "4d5743457b088acad4c9ede53f299aa502bc757d9d9bf47c19f43b094c60f868"
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
    assert_match "stuurman v0.9.0-rc.5", shell_output("#{bin}/stuurman-unstable version")
  end
end
