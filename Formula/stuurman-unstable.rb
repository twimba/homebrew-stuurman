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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.6/stuurman_v0.9.0-rc.6_darwin_arm64.tar.gz"
      sha256 "e26230c42aa415a6ee178bfdbe8801928629ea28a79320f30939f768c065d105"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.6/stuurman_v0.9.0-rc.6_darwin_amd64.tar.gz"
      sha256 "de28541bcb925010a80edca96b63e1729acf0c89485c35dcb109e114a5f3962d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.6/stuurman_v0.9.0-rc.6_linux_arm64.tar.gz"
      sha256 "a5bbc3587ceff96ec5f6d9c7ce331236df2e622284332fc2ee32772bd626acab"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.0-rc.6/stuurman_v0.9.0-rc.6_linux_amd64.tar.gz"
      sha256 "c2d9b3cfba7317a27feb0c3dcab1e1632aedb600f09c60c8aa4ec5e2e094497f"
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
    assert_match "stuurman v0.9.0-rc.6", shell_output("#{bin}/stuurman-unstable version")
  end
end
