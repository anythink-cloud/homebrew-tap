class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.21"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.21/anythink-osx-arm64"
      sha256 "c969a8bab0dede0668466d01a93f60f3297235beb3488a5530b1ef0d2816aca2"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.21/anythink-mcp-osx-arm64"
        sha256 "041e31285744f43ffd5f64eb5b76f1f0ccd8c327c72ebb4808dd02306b0da7dc"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.21/anythink-osx-x64"
      sha256 "069eedeabacc982d73cc1186c662e171579dec5aa6175b8cdcf6cd7ed80eafd4"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.21/anythink-mcp-osx-x64"
        sha256 "96aa0c6cf38930259fab910f210f3d3451a4b00bb19ba973fcd73be487928a00"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.21/anythink-linux-arm64"
      sha256 "36e27a132b70bc5be53b08a50920b98e13d0de7933245c7084360b51294222b3"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.21/anythink-mcp-linux-arm64"
        sha256 "bc12f0c513e75a62b569069f0f8d8567547371e52d9a9f226b82a94581e7b114"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.21/anythink-linux-x64"
      sha256 "4ce2702f3e00bf5e6228265505624e11930a4a04d6419050aa45b7e20941c032"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.21/anythink-mcp-linux-x64"
        sha256 "fb42de651c9ff9ba611f2dbb2b9d3174e0d4af58976382a26d934a6fd0b190de"
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
