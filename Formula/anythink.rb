class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.15"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.15/anythink-osx-arm64"
      sha256 "22ac7120d4639f5ee703b0d871bf27239c95c9c53b5405945557bd90fddf10dc"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.15/anythink-mcp-osx-arm64"
        sha256 "dd66d82adc9bdb044fae6a114ff09b3aecd68820e49800842b9ef77a24fcdf3e"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.15/anythink-osx-x64"
      sha256 "910ac1aa2b10f163eaf66638a0e7b642f36a8e91d3c5e988176f9fc9b7d58481"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.15/anythink-mcp-osx-x64"
        sha256 "8ee1914b87b82a2e11c9a13d35246f1169a2c60f5251cf3bcecf22a327188e1b"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.15/anythink-linux-arm64"
      sha256 "2d6ba0045419d12ea69c8ff67e37fbe411874c64f9b0457a0d6c0c130bb0f6e2"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.15/anythink-mcp-linux-arm64"
        sha256 "887aea725278c4cabeb48c03a73c22b20c83d4a5f8f2aa533ea5e63a248dc395"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.15/anythink-linux-x64"
      sha256 "806a6d9bd54c80d144d634425413ee8f3cea9446ba4714fe91bf345f2f66ea31"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.15/anythink-mcp-linux-x64"
        sha256 "53c08fa47e54b5bef387a1997367751cf0da40833f9795669a8742b39c96e852"
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
