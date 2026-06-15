class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.13"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.13/anythink-osx-arm64"
      sha256 "9ab2c1de54b632c2dfc298873ad9a823646a29c0cf8a5448a84a1479ce0058be"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.13/anythink-mcp-osx-arm64"
        sha256 "f5db28fa27de2bcb2e325c492f86f1d466ce5f5a5bc799bd244ac08d78567519"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.13/anythink-osx-x64"
      sha256 "f398a10d124853b3068e655813db623f985c52371499a3861463457de181e132"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.13/anythink-mcp-osx-x64"
        sha256 "cba6c14e8ba43082fe01c3e0238b2d0118eb1a04bf12eaaabf2d2b4a6d6f4b8d"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.13/anythink-linux-arm64"
      sha256 "60153c1b6cbfe14db555019a77f86447b2ebb250f7de76a0d7566911d8b60a22"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.13/anythink-mcp-linux-arm64"
        sha256 "8ba6daf5cb7c07a9feabc5daa07d75ad35e8007ead171ae6da1067c909a4ffe7"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.13/anythink-linux-x64"
      sha256 "39327598fbfa5393b06647c3984ff794e9ebcb3cfbd92cb528fd6b695c7f3fb5"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.13/anythink-mcp-linux-x64"
        sha256 "318d37ea00dc0c0acd58f080ac9b1338904b9e9b86a201ea0f3773bd158abd8d"
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
