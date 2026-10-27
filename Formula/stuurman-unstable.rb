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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.2/stuurman_v0.9.0-rc.2_darwin_arm64.tar.gz"
      sha256 "82cf1b6daca0e9fbaa8e8bd6991f19253e545b757f4b51b774c5d4e070f299e0"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.2/stuurman_v0.9.0-rc.2_darwin_amd64.tar.gz"
      sha256 "7516eaacb9b32d20e9acd381de23bfb60b117516324c2f634f4209f3548eb1a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.2/stuurman_v0.9.0-rc.2_linux_arm64.tar.gz"
      sha256 "68bab0bf5f8fe637e4e8a6580a56ec507465588122a386ad92ecc7c7cd2f3e4a"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.2/stuurman_v0.9.0-rc.2_linux_amd64.tar.gz"
      sha256 "a98b6fbf906ad11e1d77c52cdd7898ba42d0d9d3d72c6df93a27c9701d7852c0"
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
    assert_match "stuurman v0.9.0-rc.2", shell_output("#{bin}/stuurman-unstable version")
  end
end
