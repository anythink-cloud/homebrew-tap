class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.5/anythink-osx-arm64"
      sha256 "05a853998ba7a0656ced6da3c257b891c1964a973451e3cb26be8928000802fe"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.5/anythink-mcp-osx-arm64"
        sha256 "b927114fee5bd2c116bfae499d4d1d13531639840f40e40ff83ee054b9757e39"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.5/anythink-osx-x64"
      sha256 "64e4ed892f188cb0c183d01cd5458a435ad6c4972d42f8fe069cda0c864e6f51"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.5/anythink-mcp-osx-x64"
        sha256 "77586672e22b6cecfae5156ced5cb57ed277da762d0178fa8bf6820457889fb2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.5/anythink-linux-arm64"
      sha256 "a7d9a56aa533277b502a0d10510d15604b8ca79f3388a11d155b1d77505def36"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.5/anythink-mcp-linux-arm64"
        sha256 "5165a8b039f595205f5ebd4e88fce94bd843ee988dc8731ca2d13c11070de4c4"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.5/anythink-linux-x64"
      sha256 "4a0ed796a478e30cb233616cd05fc12a59fcc0df931b4bd7da644e736a52ff1c"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.5/anythink-mcp-linux-x64"
        sha256 "7a9bd18f6db357152ec367017237b6c80d874de408d971ff94c1cd7ca3b2dc35"
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
