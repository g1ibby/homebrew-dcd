class Dcd < Formula
  desc "Docker Compose Deployment tool for remote servers"
  homepage "https://github.com/g1ibby/dcd"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/g1ibby/dcd/releases/download/v0.2.3/dcd-x86_64-apple-darwin.tar.gz"
      sha256 "d472ca0fc5bb77d4f84bfff617b54258579dcdb64c164e9a840824af66340d78"
    end

    on_arm do
      url "https://github.com/g1ibby/dcd/releases/download/v0.2.3/dcd-aarch64-apple-darwin.tar.gz"
      sha256 "393d9ef83145d0d947ce7c18a3564233740c9678f13b1f23a15502b053523cf4"
    end
  end

  def install
    bin.install "dcd"
  end

  test do
    assert_match "dcd", shell_output("#{bin}/dcd --version")
  end
end