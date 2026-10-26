# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the four SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.7.0/stuurman_v0.7.0_darwin_arm64.tar.gz"
      sha256 "a02ba8888c5d45110b860615d7905bc5e319c084a155a7168fe6e4bc6e27bafb"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.7.0/stuurman_v0.7.0_darwin_amd64.tar.gz"
      sha256 "13c530f7e7cd2d66118d7104b739fa89b7f02fdb5b42226e21dd78aba4c5884c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.7.0/stuurman_v0.7.0_linux_arm64.tar.gz"
      sha256 "79087a0eacffa995156ade6130c45864fa1a36ea73c7c05fa9ff6893ff7a62e3"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.7.0/stuurman_v0.7.0_linux_amd64.tar.gz"
      sha256 "b99e73e6672e2051a58ad5e4c254187a33467bd7d1b2ccc1dba0f17f6673c0a6"
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
    assert_match "stuurman v0.7.0", shell_output("#{bin}/stuurman version")
  end
end
