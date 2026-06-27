class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.18"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.18/anythink-osx-arm64"
      sha256 "7d942c746439d3b1f552c5db8fa566c3ae504bd95a68839f2eed0cd6052bf93c"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.18/anythink-mcp-osx-arm64"
        sha256 "8ecd80c2243ec77122ddd08d2362cd59b7a9b6c6c9edd11d9e744f719f230e47"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.18/anythink-osx-x64"
      sha256 "1c840edb1c6ea00bccf71d10028331cdc093825407ad8f7c44d2ea31796f5c95"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.18/anythink-mcp-osx-x64"
        sha256 "18fe03b8514c8fa8fd819e85149bb3a83e5041021b7f66fa709d7be174dc8957"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.18/anythink-linux-arm64"
      sha256 "3fa827880d8d4787f7535d2c15d9cce6277457794d1d114633caf56548cee4c2"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.18/anythink-mcp-linux-arm64"
        sha256 "a6c66a5ad06394ab54f4688eab847b827eb0c1d9485422b1d5d484906e11bb27"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.18/anythink-linux-x64"
      sha256 "f3bc65e5fadaaf9e8e743cc55ac6da1e830680f2c38f09c431c3e0b36508a2cf"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.18/anythink-mcp-linux-x64"
        sha256 "99a10a2d0e242b10e5bcd578b96790bd48daf40d9caa0e5265c427a1a360793b"
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
