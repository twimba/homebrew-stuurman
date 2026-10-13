# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the four SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.4.1/stuurman_v0.4.1_darwin_arm64.tar.gz"
      sha256 "313a65c5f0112989c95c3c5a0736fcb032c0d0aa6806496fa83536168281dc17"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.4.1/stuurman_v0.4.1_darwin_amd64.tar.gz"
      sha256 "2bebde87147ce4b43fc3da4dd8c1b2c3106f6b3f3f655c2f60f19bb317df5dd7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.4.1/stuurman_v0.4.1_linux_arm64.tar.gz"
      sha256 "461345d4fd17be8d69d8984362fd9142d3aaf9b70569a9a0bb9cc97cc566e78b"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.4.1/stuurman_v0.4.1_linux_amd64.tar.gz"
      sha256 "037d8e50dbbbbc6a6cac612d6a728167c1119cad0aaf51f2bf5b91e43d6729ac"
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
    assert_match "stuurman v0.4.1", shell_output("#{bin}/stuurman version")
  end
end
