class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.23"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.23/anythink-osx-arm64"
      sha256 "d353afff7acb25c2561b739af3741e32d5132f7307b437ee0999b3402679a524"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.23/anythink-mcp-osx-arm64"
        sha256 "4567f56e79d79ecf952eb966e09b779895d84ca7abe4c24ed6fe65bf4251d66c"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.23/anythink-osx-x64"
      sha256 "8c703c7ab23d8528344a93e9feb66eb1f3221e04be7a92624f249de93e357945"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.23/anythink-mcp-osx-x64"
        sha256 "9037d67da22ac0800b4d53a513029cbc4a39e9c379a6004a4eb6b7d3369e4148"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.23/anythink-linux-arm64"
      sha256 "945a10e131301513715bc5c8269b337564bab2e86dbeb9d229f0e96c7aebe54d"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.23/anythink-mcp-linux-arm64"
        sha256 "98472d85ddb13821b8e18d65631e7f5666cc4d04d8a1608a85d92e69c0dcf996"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.23/anythink-linux-x64"
      sha256 "50b6cd139928768f6598a8a1b5f684fa386e9cca3ecf08b6fde964c64ed67452"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.23/anythink-mcp-linux-x64"
        sha256 "a9cf192613545e618932a1a85c13f6a6590b3eb8b0594417c5ae9c940d995360"
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
