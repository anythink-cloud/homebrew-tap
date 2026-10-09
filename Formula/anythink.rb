class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.28"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.28/anythink-osx-arm64"
      sha256 "b271b6a6436a8443ef84e989feb92c565a4b0d5e8c1ff02af099d5a852577f3f"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.28/anythink-mcp-osx-arm64"
        sha256 "6151d4c587c2bbbb1d272cdeacd669aac3d6310979ad1560c6b549aa45a01e31"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.28/anythink-osx-x64"
      sha256 "798c7b2a9b08545566c44428c8ad9df45c6af3b1dfc0d6478dc1463ae20af754"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.28/anythink-mcp-osx-x64"
        sha256 "6087fb04167dcbe5ca0d63d4b0400c128904c18f1bf50d221ab7389faf6533ef"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.28/anythink-linux-arm64"
      sha256 "97f91b4034f7bf7d677e967f90212470542d5068f1f7defb22f0046863064e21"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.28/anythink-mcp-linux-arm64"
        sha256 "750e4ae238e53cc1b79cef5b9de921be006237ae8f8561dc4c22aaaa44bd8e0a"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.28/anythink-linux-x64"
      sha256 "d603900c6500b4c72a5be14447608b9c73b2f9291f77ab972b657e4d1c6d302b"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.28/anythink-mcp-linux-x64"
        sha256 "3a03bafd8a19762d56fd8f31296d1c237e8f51ff023a47eb7e165fc5715a43a9"
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
