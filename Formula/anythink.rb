class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.10/anythink-osx-arm64"
      sha256 "22dc0786696c76148a1d169108ed6556b419afacabd3b1dd9dfdb4ab78090b8e"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.10/anythink-mcp-osx-arm64"
        sha256 "d5749bc7bd96bbc5e2d8d6a843c8e88bf22e10752a9be5cd45927339757f8a0e"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.10/anythink-osx-x64"
      sha256 "77ca8c7bb83dad9e1dcc9002eadf0705598ba5a159406a8c9313794fafb6592a"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.10/anythink-mcp-osx-x64"
        sha256 "b4f9568d0182411be60d0311eecd87f454add4b13eda620344dd3bac0b7b0857"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.10/anythink-linux-arm64"
      sha256 "8680fd75dcea1d3c212722a5387e24ab6103d38a0dd67985609a965c847c6b35"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.10/anythink-mcp-linux-arm64"
        sha256 "16498b0105b5f3a5abd8dcacacd80eb565c2531aa3523b11af5e140257c75eed"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.10/anythink-linux-x64"
      sha256 "cb0a8832b68aa4b08b8399ba6423ca7929cf91f1c37ee4154ab1736117893d04"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.10/anythink-mcp-linux-x64"
        sha256 "89bcfbd79fe440d1b3d3bfba08c4a05ae6e0c6ad8f31917bd4d3ca3edadd32cc"
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
