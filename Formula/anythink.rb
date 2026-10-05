class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.27"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.27/anythink-osx-arm64"
      sha256 "169f17930e57b21b912698dd2ce7fd31d74785d17d033138603446b1e5a33bf3"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.27/anythink-mcp-osx-arm64"
        sha256 "6a19d6a459fa9ea67d1bb485a98df1b5e34892bb4b413e3024818007add577e0"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.27/anythink-osx-x64"
      sha256 "ccae633ca5f8ad83ef521f075b484be603aab951640e003e34c99c154097d873"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.27/anythink-mcp-osx-x64"
        sha256 "fe8cad6a71fd836a165a4dd9f31ce3ee966780d71c4fb5704653fc8aba55c84e"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.27/anythink-linux-arm64"
      sha256 "5a01bd01cd18bcff5f332f55d6d161be67c51a039e89b948f48ccfc7328d97f3"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.27/anythink-mcp-linux-arm64"
        sha256 "6be7eda8aa6e362b95b5dd022d580757cdd572e9b6dc2815f8e4f6a3233e0192"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.27/anythink-linux-x64"
      sha256 "1846787fb79ee76f5526dbcdff31f07dfa29d96dc8ee3b80eca6ee555ea94383"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.27/anythink-mcp-linux-x64"
        sha256 "f1a72f645e84d4ee9ef76740492a883244875c29a3b827ea4a1e1bd1e7805346"
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
