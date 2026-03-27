class Anythink < Formula
  desc "CLI for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.1.0/anythink-osx-arm64"
      sha256 "ad37292c36cbbb77d79c0073a3aadccf437db9126b0e3bdbf79d6b60d555b919"
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.1.0/anythink-osx-x64"
      sha256 "214713d7c63f6a47ee2ada8a2b97d94a1057942d0f1a66fb255130c70c00d28a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.1.0/anythink-linux-arm64"
      sha256 "9eddef1da15c7e995d45a674d4a99c12cb34a9adff62050673748c6ff627cf13"
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.1.0/anythink-linux-x64"
      sha256 "0e9b4b03e4f7e44d70748a896943ea00d4baec0c38e2f4797e7ce26c0c6e652b"
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
