# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the four SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.6.0/stuurman_v0.6.0_darwin_arm64.tar.gz"
      sha256 "1db2abe97e2a9c039499631663796e4b95fc2f11dc1bfd81efaa71aa83f7946f"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.6.0/stuurman_v0.6.0_darwin_amd64.tar.gz"
      sha256 "363b92d8506da536fd829b8cac3e4dc0c5804e419c24e39fa6d3c776e2624eec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.6.0/stuurman_v0.6.0_linux_arm64.tar.gz"
      sha256 "40cf48aa6691bfe650aeb606a54cce4b6cbab8bf38bff0ba523dac8626f56ab1"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.6.0/stuurman_v0.6.0_linux_amd64.tar.gz"
      sha256 "9b416e73344034700507d0938f1fcd1604f6e6a60183e182afcde0ce0b4f84d1"
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
    assert_match "stuurman v0.6.0", shell_output("#{bin}/stuurman version")
  end
end
