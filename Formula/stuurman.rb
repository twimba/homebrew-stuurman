# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the four SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.5.0/stuurman_v0.5.0_darwin_arm64.tar.gz"
      sha256 "77c6566ef003f903a4cdadaee8ed4ca09189bc1429436dec1a5b102c6cc4fc39"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.5.0/stuurman_v0.5.0_darwin_amd64.tar.gz"
      sha256 "d6abb0c778b4419538333a9a4a39fe751ac2ed96253e42620b96cc59b215f956"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.5.0/stuurman_v0.5.0_linux_arm64.tar.gz"
      sha256 "f487bb211334a908b22fce2927f09d48b1b3edee4307b0893e992535995d4ab6"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.5.0/stuurman_v0.5.0_linux_amd64.tar.gz"
      sha256 "706e60c875b55480d966504586a8614e9d3111758b7d611d26d2c2e03d20b46e"
    end
  end

  def install
    bin.install "stuurman"
  end

  def caveats
    <<~EOS
      Run stuurman install to start a Ship. Docker with Compose is needed.
    EOS
  end

  test do
    assert_match "stuurman v0.5.0", shell_output("#{bin}/stuurman version")
  end
end
