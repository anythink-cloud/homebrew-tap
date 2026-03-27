class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-osx-arm64"
      sha256 "77800e66e870a5e6c078b4f13097facbfbbabddf88718d87df82d499f21f9077"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-osx-arm64"
        sha256 "38bb1339084dcd2701222fbaf4166e4b576a100510b8e4834cc5f3890b56b7d4"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-osx-x64"
      sha256 "cf130b1f86251fd1ceb9c4babc6dc03aae49c4ec0c7be7542fca72b07ebfd1be"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-osx-x64"
        sha256 "322c95653843f8d4b0e64fbfe28308b163e3b036573aaa2187800a871a910f33"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-linux-arm64"
      sha256 "027fbb51fa0d6c57f48fa3f3a3a5dad083dcdd427098abb8903c5b7428425509"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-linux-arm64"
        sha256 "8a99b3ffd3c5b83d2c08733dc14f96965c077ccf438015aaaea90dbbf9b25d1a"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-linux-x64"
      sha256 "9051f26cb16cc7c4d748664fce5b409e44fef87a410bc6069dec09c02e67e6e5"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-linux-x64"
        sha256 "54ac9c5b6ec944eb4a16c0ee7efa977190ae0554ec9cf4ba9cf93daf0f571aa8"
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
