class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.33"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.33/anythink-osx-arm64"
      sha256 "34894e5a002c0277ac2cd3ebd9958a5a9825af624edda371581a0dc908cba5f9"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.33/anythink-mcp-osx-arm64"
        sha256 "c4dd2169f8c11d23e1d3a119e988ed8f224c65fae6f1b022efa34a61f43e619d"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.33/anythink-osx-x64"
      sha256 "683684cfbfd0325c0afdc6afc8356fce851b720a6d95c6691a94e1e4abc16823"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.33/anythink-mcp-osx-x64"
        sha256 "3aa91ea9cf93b76db4c20eea36a99a05e8e59d3eadde66b0c69fac8ff69fbbd2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.33/anythink-linux-arm64"
      sha256 "8e586f76f78cd33abde1311f8b4782479de2d401233632092d98eb1f42f6e1ed"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.33/anythink-mcp-linux-arm64"
        sha256 "4c6eaf16738046ce2aa54b32a196728db962b96271c21e024e35fe6b669bcb41"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.33/anythink-linux-x64"
      sha256 "4b8e37f01d8c19f8a6fa8ed3632a224647144abfde19e055c8973f36242d0438"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.33/anythink-mcp-linux-x64"
        sha256 "5f875f44fcd404e9145391d704b35a10c08c53d8dfd107dbd78d8380de03dc7d"
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
