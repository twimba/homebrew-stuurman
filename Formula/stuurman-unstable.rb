# The Homebrew formula of stuurman-unstable: the stuurman command installed
# under the name that makes it follow release candidates as well as releases.
# It is written for each release candidate and each release newer than the
# last one from a template (the tag and the two SHA-256 values are filled
# in); a change made here by hand is lost with the next one. Homebrew reads
# the version from the urls.
class StuurmanUnstable < Formula
  desc "Command that installs and runs a Ship, release candidates included"
  homepage "https://install.stuurman.io"

  depends_on arch: :arm64

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.1/stuurman_v0.9.1_darwin_arm64.tar.gz"
      sha256 "f80d9f73dd244f94647859f1a678bdf01375f01b65a1767f815a0e5702927e78"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.1/stuurman_v0.9.1_linux_arm64.tar.gz"
      sha256 "d501a70a87215a2803d73e8fbb7a14ec98232a63eca649c3d8d3a1de8a4d0dd6"
    end
  end

  def install
    bin.install "stuurman" => "stuurman-unstable"
  end

  def caveats
    <<~EOS
      Run stuurman-unstable install to start a Ship that follows release
      candidates. Docker with Compose is needed.
    EOS
  end

  test do
    assert_match "stuurman v0.9.1", shell_output("#{bin}/stuurman-unstable version")
  end
end
