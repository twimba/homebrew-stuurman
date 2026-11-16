# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the two SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  depends_on arch: :arm64

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0/stuurman_v0.11.0_darwin_arm64.tar.gz"
      sha256 "282c55282b893d21a5f5f65caa6b527e078fc50edafc7c38b2b3959e8c3f91ee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0/stuurman_v0.11.0_linux_arm64.tar.gz"
      sha256 "acf0d3f57856ad2b6ec145137d17d29264ed8d64631d66755247d0bb973cbf7a"
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
    assert_match "stuurman v0.11.0", shell_output("#{bin}/stuurman version")
  end
end
