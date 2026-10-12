# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the four SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.3.0/stuurman_v0.3.0_darwin_arm64.tar.gz"
      sha256 "ba6e9989764d1ba706e2572b022dcedd6b411ec21acd4898ca666e6ccb1ece2a"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.3.0/stuurman_v0.3.0_darwin_amd64.tar.gz"
      sha256 "ddced2713ccbfbc8531f6d429c6fe339562009fecb57ffc6b61a1f6ba1c5fc88"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.3.0/stuurman_v0.3.0_linux_arm64.tar.gz"
      sha256 "909dce49cc6fb86cb54ffd027b24ecc626052d608b5176ba3622e492033c9e19"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.3.0/stuurman_v0.3.0_linux_amd64.tar.gz"
      sha256 "bc14d6f5e9e4089d6221e6f9089ea6064bff6836e61c5ed90e67859a671423ea"
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
    assert_match "stuurman v0.3.0", shell_output("#{bin}/stuurman version")
  end
end
