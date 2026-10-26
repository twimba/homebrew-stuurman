# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the four SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.8.1/stuurman_v0.8.1_darwin_arm64.tar.gz"
      sha256 "c0b87c1c01d2dc77d202313a3289d3e5ea07b0fcef7a0691531da704a12025f1"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.8.1/stuurman_v0.8.1_darwin_amd64.tar.gz"
      sha256 "9e02b55c6762f1cfc9485a429de9e644eea36844c881b6747e06f374ac5f8baf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.8.1/stuurman_v0.8.1_linux_arm64.tar.gz"
      sha256 "dcbfa7d78550e1ca90501c71818382999e36a79515f7adbe6df7d7228dacf847"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.8.1/stuurman_v0.8.1_linux_amd64.tar.gz"
      sha256 "6d2b90a426f022d6fd001dd892fb1730a76706f29db062559d4d1db242885bd3"
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
    assert_match "stuurman v0.8.1", shell_output("#{bin}/stuurman version")
  end
end
