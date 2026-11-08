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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.10.0/stuurman_v0.10.0_darwin_arm64.tar.gz"
      sha256 "dcbb4be7bbd83c3b2117511a4b27743ab57f13403ad1fbe4b82a50f6602d8a1a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.10.0/stuurman_v0.10.0_linux_arm64.tar.gz"
      sha256 "4ad0c5821df7ae321602dfa1e78a61df5cee67f12fade0e240c3c9a265ef3488"
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
    assert_match "stuurman v0.10.0", shell_output("#{bin}/stuurman-unstable version")
  end
end
