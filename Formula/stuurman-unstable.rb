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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.1/stuurman_v0.9.0-rc.1_darwin_arm64.tar.gz"
      sha256 "1c91603bf1814d4fc167321cd059397f47fa48566726153ebb79cff9a9b40f2e"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.1/stuurman_v0.9.0-rc.1_darwin_amd64.tar.gz"
      sha256 "85bd96b14f23656be89b6b89c51751d49db40ab4b45ab700d8641053fa982c49"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.1/stuurman_v0.9.0-rc.1_linux_arm64.tar.gz"
      sha256 "49aa0a442e0fe9515b1c8369affcc51dc81a28a2cfa5d59cb2a63f19e054ed74"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.1/stuurman_v0.9.0-rc.1_linux_amd64.tar.gz"
      sha256 "bb19a20a17cb78a2abaec93f61962c85a7ea6ec4bf5fb80dd706811a472ae137"
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
    assert_match "stuurman v0.9.0-rc.1", shell_output("#{bin}/stuurman-unstable version")
  end
end
