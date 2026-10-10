class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.32"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.32/anythink-osx-arm64"
      sha256 "a4493fad6df8c80146d5590ed33be220657e23d8c63e6745452cc296585a555c"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.32/anythink-mcp-osx-arm64"
        sha256 "7973630f8f413f9b2b56057e3eddbb621d4e34d7b3c9d06f76f34ae41630a88a"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.32/anythink-osx-x64"
      sha256 "5e2c70466bbf18f85df1b3d891faea371fcdbb6712df68b833eb69482236ec03"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.32/anythink-mcp-osx-x64"
        sha256 "787b32e414689b712bd184cb96978ef367c46428bd1bd6e4efb006b7915583ce"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.32/anythink-linux-arm64"
      sha256 "18f0210639389e9ab4de23494ba6c0c78cdda36cbe7d5b2d2801beceb1ab7726"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.32/anythink-mcp-linux-arm64"
        sha256 "68b144dcd823a6d55d8bdf19c674a6427139a316e2aa73f9cbcebb8f293f1b8c"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.32/anythink-linux-x64"
      sha256 "dafe04cd414073f1be69d52bbac99c2cd43884a5aa50a195ffb2729391196558"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.32/anythink-mcp-linux-x64"
        sha256 "121be8e6ee969b3781816bb9ad84e9af367d85613882385440567940f8c6b0c9"
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
