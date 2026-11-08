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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.10.0-rc.8/stuurman_v0.10.0-rc.8_darwin_arm64.tar.gz"
      sha256 "f34071264c5b5dd5546a194cbc83b164dc59bb1f7f626e4597c11ce9c7b20089"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.10.0-rc.8/stuurman_v0.10.0-rc.8_linux_arm64.tar.gz"
      sha256 "c41b83a352377dd38829b7f60e8956064bf115e333207244d203d31f4b6eab13"
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
    assert_match "stuurman v0.10.0-rc.8", shell_output("#{bin}/stuurman-unstable version")
  end
end
