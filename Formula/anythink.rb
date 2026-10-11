class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.37"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.37/anythink-osx-arm64"
      sha256 "c06181605630a4ace5e7e69f3035cf66926ac2b7e9550788472092550e886900"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.37/anythink-mcp-osx-arm64"
        sha256 "b2b1de61f664143de02a4f3e699ddba8b471a2c38af868717ea34a1cc503fd35"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.37/anythink-osx-x64"
      sha256 "3e89dc96e650988bc599c64e679ef43c60e0157e6f06a3ec51ad893f95dd93bc"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.37/anythink-mcp-osx-x64"
        sha256 "ace9913b66784f8c9b21a2f8c9c02d5f5c22d9118c452b685c7761ed6b2468a0"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.37/anythink-linux-arm64"
      sha256 "4aa4ff506d121553095b522310f91f12a791bc116e8d84132f04ff58a097409f"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.37/anythink-mcp-linux-arm64"
        sha256 "3b19c20977942e2ae50060819fa9c7792f10b050b14deecfb2e9d246416db664"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.37/anythink-linux-x64"
      sha256 "4279eb6fd8d3c31060c6c642185adbd91e59bb1a9ba13ea14345777b2c837058"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.37/anythink-mcp-linux-x64"
        sha256 "01678cf859c1f6cbf25538212a8bbec585a3fcbadbd34102666fb27359a95aac"
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
