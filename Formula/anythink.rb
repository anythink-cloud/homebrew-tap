class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-osx-arm64"
      sha256 "b01fe275d5b5b331d2798c7dcf2dc18035e13ea7694dcc0d9e5d2cfa9e856181"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-osx-arm64"
        sha256 "49d79de4edf257aa7af67ec5a1f4d47cb72b0a2597ee152066412aa704fd5f6e"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-osx-x64"
      sha256 "dc4e81d9714d40464ea04fb852b0e22c047d179799f72c86b96a0f60ace7fc87"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-osx-x64"
        sha256 "6589992074676d318b9b1ee59d7c8a2510fd3b08c9e053215f2edaa238ed092a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-linux-arm64"
      sha256 "db55f34cf9d1d7d684b2fc2dc30ad35e8b151471781fbd0a153d29024be52639"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-linux-arm64"
        sha256 "c9dcf8391e63a12291fffa5bb9ebe25e59f7a0484a21d9b7c78f7da5db65f4a6"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-linux-x64"
      sha256 "14552de0fc5b5f71accc3e67869812f3cba952727095c29d8059ae81e4f17cbb"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-linux-x64"
        sha256 "79230a00a20d6f841b2c2278d6432261e1e785e90f87a1c6bb3a6a8787bf4cd1"
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
