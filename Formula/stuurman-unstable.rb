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
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.1/stuurman_v0.11.0-rc.1_darwin_arm64.tar.gz"
      sha256 "136b9f4745a405857e63be1df7e2fb7086d78e30f704ed13dde94375139a7666"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.11.0-rc.1/stuurman_v0.11.0-rc.1_linux_arm64.tar.gz"
      sha256 "cd87e17090589cfb7875396e665baafb4a3ad2ee22f4aaf8f1b7a71f4fff2482"
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
    assert_match "stuurman v0.11.0-rc.1", shell_output("#{bin}/stuurman-unstable version")
  end
end
