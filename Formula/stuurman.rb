# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the four SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.4.0/stuurman_v0.4.0_darwin_arm64.tar.gz"
      sha256 "680524c155ee3edbb2497863bb402c74886750d59c31f3bb709a10d9665a3166"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.4.0/stuurman_v0.4.0_darwin_amd64.tar.gz"
      sha256 "1721a6f14aef8e33d594b404a7e972e60c630874b27660adad559f4fc1d41723"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.4.0/stuurman_v0.4.0_linux_arm64.tar.gz"
      sha256 "67b3cc6657c981a8e9a2a3fac53853faa580f6424cf994c7193aea9281bee2cc"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.4.0/stuurman_v0.4.0_linux_amd64.tar.gz"
      sha256 "1a7a5855b0d9e018cf6e6c595c073d554729bf4787978c02a6d55a5e076338c0"
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
    assert_match "stuurman v0.4.0", shell_output("#{bin}/stuurman version")
  end
end
