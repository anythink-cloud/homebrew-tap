class Anythink < Formula
  desc "CLI for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.1.0/anythink-osx-arm64"
      sha256 "b2dac9b4821474ff5a56e173f0855d499e6ad0cf6b8ae2cca6e568c4a8ae073f"
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.1.0/anythink-osx-x64"
      sha256 "c583cda7e0b8ff7b5c2f56ce0d99dd1d4bbf839aae6134aa5dfea33534ce8871"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.1.0/anythink-linux-arm64"
      sha256 "77599fb1b8f1cbf283f2f09932131a093d8760a9f59152a3fd346a1eb3b6fae1"
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.1.0/anythink-linux-x64"
      sha256 "898abf53b6c5dc27eff07695807d6ad8545a3b07212ee46e6b294477befeeba3"
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
