class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.34"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.34/anythink-osx-arm64"
      sha256 "b382af7d39f91cab7dd63f0d83dc3123f38c9a269f9fb06028387b10570ed6bb"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.34/anythink-mcp-osx-arm64"
        sha256 "3692f0a2dc08739de3aefacb4a7f02ef28d78ff0762e9d69b6d053d636a96a9d"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.34/anythink-osx-x64"
      sha256 "bd3bc2f35d5252689ded4635f0431452db16eff04b9bc0e04e9735f9349b1d21"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.34/anythink-mcp-osx-x64"
        sha256 "c0aa20b388bec53529965daa1c4d85dc33b9b49a80679066272e3c84c8ddd8f7"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.34/anythink-linux-arm64"
      sha256 "a3dfff8b12eb129fb8b3239db52068cbe97223d51f9cce860e021464bfac4707"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.34/anythink-mcp-linux-arm64"
        sha256 "9f3250f1c590fcfcd2c916364775a4bb380a1068a6da2419e217fd2ed2476cbb"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.34/anythink-linux-x64"
      sha256 "22ff538601e04a4584b8a4ff6c9e4d16c6c11feb571ca14e8cd86291a1e3a6a4"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.34/anythink-mcp-linux-x64"
        sha256 "9cfaadfeb95bfe7d486bda9fb5ce0f0f9e7f16b89f69c1782bb230f164b57ae8"
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
