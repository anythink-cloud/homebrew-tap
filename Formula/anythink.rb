class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.35"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.35/anythink-osx-arm64"
      sha256 "9e1b0cb1e19cb0d862aae286ae1808fb5c73aa05edf30dd42732d2b8e308e872"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.35/anythink-mcp-osx-arm64"
        sha256 "19d83f3dc90da0e45c3c04e6e19815148342e639d20704b30519755509a08339"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.35/anythink-osx-x64"
      sha256 "304150512ea2bbcc835145a0554ea289ad196d05e5b6746e065410284a5f6c0a"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.35/anythink-mcp-osx-x64"
        sha256 "a6a4913a7dcb0ed6f7fac7e642a59052caaca1961f7d503a160d19aad15f95ed"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.35/anythink-linux-arm64"
      sha256 "ec02cf8a4d2d686d720e055b281d190668fe22e0dc8bc4bede0c76d72eefc0c2"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.35/anythink-mcp-linux-arm64"
        sha256 "558bab0b73c0842e1c1b08330a76d30c350fd544dc106ebdd0585b033b6aa90a"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.35/anythink-linux-x64"
      sha256 "7f64c6bc97a29f0f765359d8047568cbef6a7d399e6b541f017d1c389c8f2beb"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.35/anythink-mcp-linux-x64"
        sha256 "90537e97ef0e15213439b9a994687e1119e11aaa35bcffb42816ed7e4cc4280d"
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
