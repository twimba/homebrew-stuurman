# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the four SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.5.1/stuurman_v0.5.1_darwin_arm64.tar.gz"
      sha256 "3f0fe7e6484824adde8ed3a001d1180c599417a49304fabc59ecfc30f81b9442"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.5.1/stuurman_v0.5.1_darwin_amd64.tar.gz"
      sha256 "98e483639a8f7f4688885791d6b96724d034377ce2c556ff29b4174724b2b506"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.5.1/stuurman_v0.5.1_linux_arm64.tar.gz"
      sha256 "62289a203deef69f153e5c8def42c0f1627635a7291d63de1621ff5d2ec2723f"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.5.1/stuurman_v0.5.1_linux_amd64.tar.gz"
      sha256 "1788f335bf5f5ff14d6cd3295d622e00e344e2e84319bcbc9e9ec6686ef12f78"
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
    assert_match "stuurman v0.5.1", shell_output("#{bin}/stuurman version")
  end
end
