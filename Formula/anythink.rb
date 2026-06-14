class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.2/anythink-osx-arm64"
      sha256 "ced7e2f122c82c86f3ca28882b9969c911a0f438a9be1822f3d364f50f448a24"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.2/anythink-mcp-osx-arm64"
        sha256 "2e48eafaacd3fd4dc9ca8cf54ddd19ee1654767863a9279fba2826b947cd95b4"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.2/anythink-osx-x64"
      sha256 "7d1e062c2dc41b8740c81e99395dd253f68d164ab7a5cce9e8b95fea33971c0a"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.2/anythink-mcp-osx-x64"
        sha256 "be57194617aeb8dea9041d5630bd1a1ab0e93a0335ccb0a1af32d37fda08c001"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.2/anythink-linux-arm64"
      sha256 "04e4d3cb73a1b541f2ed74f45f55066b412810be5467d816f733b1a9d015b1ba"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.2/anythink-mcp-linux-arm64"
        sha256 "ca60e1408caf3b5aab37d47b3296404a8bc015c2976b9db80987e03fdc67bee6"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.2/anythink-linux-x64"
      sha256 "1536398aaeca6c79de272511fd5adc9e7ac8d4c0e5dd32acfda1fffa9f56be80"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.2/anythink-mcp-linux-x64"
        sha256 "3b15156fa4d37b6c12bc95610c34d67c0b788452f1000b095dc6adf28e544b7d"
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
