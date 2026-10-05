class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.26"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.26/anythink-osx-arm64"
      sha256 "253c08b01f96d7505ca00acf89af230fc7343c17a8e460014abdd42a1762c217"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.26/anythink-mcp-osx-arm64"
        sha256 "05affdb5f351bb9ac7669ed658c2c4e27ee96a9e7f08211db8fd6c6ca35715a4"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.26/anythink-osx-x64"
      sha256 "dbbc5e28dc4c72f0b4c3ee41f86a3aea728627d28fd81a725c886f01e525822c"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.26/anythink-mcp-osx-x64"
        sha256 "213aefc38dd0891669429d490a7a8a09853015f0995c236a5c88fd9adac33de2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.26/anythink-linux-arm64"
      sha256 "e67bb4cc04ed9b83528ee2df7ad82cd8ce55b29289fe3ac37a60da7ce5597d86"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.26/anythink-mcp-linux-arm64"
        sha256 "ad98730375038aa0c30c8b1e0634ee49df52f2d9a86c08aa92d63202aa15d888"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.26/anythink-linux-x64"
      sha256 "86d5723fccd59fee19c63f54db0e0a010a6ff2fdf0f2a28e65abe41a1cb27759"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.26/anythink-mcp-linux-x64"
        sha256 "a893011326ac29ee2d30c64c212567bf44fc8492be31c189e70165f22f0e9e90"
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
