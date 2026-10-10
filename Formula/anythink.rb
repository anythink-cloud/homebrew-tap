class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.30"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.30/anythink-osx-arm64"
      sha256 "84b039fbe5133fceb43ce31cc61cbf276436faca547142e22fb9366a74d5f004"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.30/anythink-mcp-osx-arm64"
        sha256 "d4f42e508318f8fade2096c08ea1717072a57a7cc1b99adccb89a1e8a845c5fd"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.30/anythink-osx-x64"
      sha256 "a09cc4b9bacc3415d69e25df5fdbf87dd1652f7d3b4ed01184190c8fb841132d"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.30/anythink-mcp-osx-x64"
        sha256 "501b95096caa80ebb175077ca1714aa5d2e29a5cf75f00836ecbe30772b7f11d"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.30/anythink-linux-arm64"
      sha256 "7fc5e00f60757d54ad394b08db4eee9b404380c65f10f2795d72dde962995fb5"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.30/anythink-mcp-linux-arm64"
        sha256 "fba7749d85a1e7378ca30c72686b34385b1d8ccacb9febbe4536b571d543dd00"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.30/anythink-linux-x64"
      sha256 "cb7b776fe2ba92630679a5180c50900a80c6898779b9c7893e37be8a645afb3d"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.30/anythink-mcp-linux-x64"
        sha256 "7c74af097445be3643c082e34e7dfb3a7df3c7cc11dc7ab17c83dbc665d95284"
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
