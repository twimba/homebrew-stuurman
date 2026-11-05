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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.10.0-rc.2/stuurman_v0.10.0-rc.2_darwin_arm64.tar.gz"
      sha256 "2e5121a580ea426b4b323c76695f038f80ce122a7638ed0531a41f5edf7568ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.10.0-rc.2/stuurman_v0.10.0-rc.2_linux_arm64.tar.gz"
      sha256 "4eab9253c5070e71c0efd14b128a5ee09672d7e8ec8e57c903acdccf70668843"
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
    assert_match "stuurman v0.10.0-rc.2", shell_output("#{bin}/stuurman-unstable version")
  end
end
