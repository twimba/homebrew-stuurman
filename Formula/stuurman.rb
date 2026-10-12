# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the four SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.2.0/stuurman_v0.2.0_darwin_arm64.tar.gz"
      sha256 "6d1f4eaed2b3cd590adfb852610fde4d60dd15663ab1a04ca14baba38aba5d21"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.2.0/stuurman_v0.2.0_darwin_amd64.tar.gz"
      sha256 "fdd85d06d71cbfd5b7126f122ba723fb7332950d423fa4d5198ec820f7d32008"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.2.0/stuurman_v0.2.0_linux_arm64.tar.gz"
      sha256 "8e5a995f8ea101b0a0277c1977dd063209ca6a609b1026217e67aafd6ee9432a"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.2.0/stuurman_v0.2.0_linux_amd64.tar.gz"
      sha256 "afafeedfb2eb1b439573150542e6a4eb1596f781abcebfc82835e31d8e71ff7e"
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
    assert_match "stuurman v0.2.0", shell_output("#{bin}/stuurman version")
  end
end
