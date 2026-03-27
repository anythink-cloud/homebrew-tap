class Anythink < Formula
  desc "CLI for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v#{version}/anythink-osx-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v#{version}/anythink-osx-x64"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v#{version}/anythink-linux-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v#{version}/anythink-linux-x64"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    binary = Dir.glob("anythink-*").first || "anythink"
    mv binary, "anythink"
    chmod 0755, "anythink"
    bin.install "anythink"
  end

  test do
    assert_match "anythink", shell_output("#{bin}/anythink --version")
  end
end
