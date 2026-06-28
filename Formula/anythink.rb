class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.19"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.19/anythink-osx-arm64"
      sha256 "fda081aa7ad2003941157e9f493e8496ce5e388259652d1380f8415da0422edc"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.19/anythink-mcp-osx-arm64"
        sha256 "cc69b0642ca07f2841dea306caf929a38a655c3087ded27f33030130bba9d208"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.19/anythink-osx-x64"
      sha256 "676cbeb358cff02400ab0cf472ad3d4fad218976c81f53d950bc8045c9f30326"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.19/anythink-mcp-osx-x64"
        sha256 "565267e3e7ad30de8757aeef28eebe270c0eba08253a29f8f8654cc5518dd79a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.19/anythink-linux-arm64"
      sha256 "20cc9d4af49f86a63b1b48c5f0c31d0dccff923d5eebe8a2c8149e588af705aa"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.19/anythink-mcp-linux-arm64"
        sha256 "44922dd8f62b513a3fdf494475ae4b8aa239e773c3f6372254e3acc0ccad73f2"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.19/anythink-linux-x64"
      sha256 "ed6d0cd017def414cdaa8c92db32420a7f5fa3471c719e701c0b3ef551bf5f2e"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.19/anythink-mcp-linux-x64"
        sha256 "b95c879975532ee15d14691d65a1f12d09b7b6d67918caeae4aa752c9f7843ca"
      end
    end
  end

  def install
    binary = Dir.glob("anythink-*").first || "anythink"
    mv binary, "anythink"
    chmod 0755, "anythink"
    bin.install "anythink"

    resource("mcp").stage do
      mcp_bin = Dir.glob("anythink-mcp-*").first || "anythink-mcp"
      mv mcp_bin, "anythink-mcp"
      chmod 0755, "anythink-mcp"
      bin.install "anythink-mcp"
    end
  end

  def caveats
    <<~EOS

       ░███                             ░██    ░██        ░██           ░██
      ░██░██                            ░██    ░██                      ░██
     ░██  ░██  ░████████  ░██    ░██ ░████████ ░████████  ░██░████████  ░██    ░██
    ░█████████ ░██    ░██ ░██    ░██    ░██    ░██    ░██ ░██░██    ░██ ░██   ░██
    ░██    ░██ ░██    ░██ ░██    ░██    ░██    ░██    ░██ ░██░██    ░██ ░███████
    ░██    ░██ ░██    ░██ ░██   ░███    ░██    ░██    ░██ ░██░██    ░██ ░██   ░██
    ░██    ░██ ░██    ░██  ░█████░██     ░████ ░██    ░██ ░██░██    ░██ ░██    ░██
                                 ░██
                           ░███████

    Whatever you're building, Anythink is the backend at your service.

    Get started:
      anythink login
      anythink --help

    MCP Server (for AI-powered development with Claude Code):
    Add the following to your .mcp.json:
      {
        "mcpServers": {
          "anythink": {
            "command": "anythink-mcp"
          }
        }
      }
    EOS
  end

  test do
    assert_match "anythink", shell_output("#{bin}/anythink --version")
  end
end
