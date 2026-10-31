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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.1-rc.2/stuurman_v0.9.1-rc.2_darwin_arm64.tar.gz"
      sha256 "5debf684ee5ce2acefc0ded1f598fe4b18305ec44b3c715bbe94dfbc495aa5aa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.9.1-rc.2/stuurman_v0.9.1-rc.2_linux_arm64.tar.gz"
      sha256 "7cba21fc1dd075b0a87cd7f364a0735fa81a9366bd25430cd19f4a13a69bbc64"
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
    assert_match "stuurman v0.9.1-rc.2", shell_output("#{bin}/stuurman-unstable version")
  end
end
