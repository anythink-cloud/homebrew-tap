class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.3/anythink-osx-arm64"
      sha256 "b4221176cf8b8b645ed41da973fb254a49501f501dc825adee6b5c4ea6476264"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.3/anythink-mcp-osx-arm64"
        sha256 "7d59996eb61572b4792f66e3cc7811bbbe09fad15400ecc91f77b032def9d500"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.3/anythink-osx-x64"
      sha256 "bc5ff3a06074de8e2182f93a6fcaec82281bdb191d7eacb08cb195340f89d479"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.3/anythink-mcp-osx-x64"
        sha256 "599689cd9ce33e4b4dbcb33ad53ab1958f94d97f548def86a405fadcbf557ea2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.3/anythink-linux-arm64"
      sha256 "af178bd0abefe7b3513ddb2f3256b20390e089321cba53d6fde291a784aea903"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.3/anythink-mcp-linux-arm64"
        sha256 "187452950e799b32b928ed8172b3c43faf70273d8516c86b70f19754f23fcaf2"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.3/anythink-linux-x64"
      sha256 "3201b0c285000a5bfda6b1c9882aca2a21eeb892c4751ede96e8a478053d2bca"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.3/anythink-mcp-linux-x64"
        sha256 "28c1041edce32d5960164919acf1933bf3d3e1c5faffb61d90f91eb7efed367b"
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
