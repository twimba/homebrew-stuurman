# The Homebrew formula of the stuurman command. It is written for each release
# from a template (the release fills in its tag and the four SHA-256 values);
# a change made here by hand is lost with the next release. Homebrew reads the
# version from the urls.
class Stuurman < Formula
  desc "Command that installs and runs a Ship crewed by AI crew members"
  homepage "https://install.stuurman.io"

  on_macos do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.8.0/stuurman_v0.8.0_darwin_arm64.tar.gz"
      sha256 "127a043bba5cc5b150d0d5a5b895edb7d48cb07fb8b56dd628aeda5874c09452"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.8.0/stuurman_v0.8.0_darwin_amd64.tar.gz"
      sha256 "b80e2e5f757a869a6ddce0f931e7cd69659e8cc2480d6a01a7a8bc35a54b4f1f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.8.0/stuurman_v0.8.0_linux_arm64.tar.gz"
      sha256 "726f6c0bc30ac605daaba26fbc5a7229bf3cff4d771dd98eefa9de73e3a858cd"
    end
    on_intel do
      url "https://github.com/twimba/homebrew-stuurman/releases/download/v0.8.0/stuurman_v0.8.0_linux_amd64.tar.gz"
      sha256 "fca88cd728205bffe961c9c773aaf94e91b2a6c338c610571f2e9d47438f4259"
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
    assert_match "stuurman v0.8.0", shell_output("#{bin}/stuurman version")
  end
end
