class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.17"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.17/anythink-osx-arm64"
      sha256 "783be9da14ac7fb4d6deb8886e7ed34e8beedc0d9c5f90edbd29e10371c79293"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.17/anythink-mcp-osx-arm64"
        sha256 "19dd01b65228a9e50b6d9f59f8e43340a28443a0dba9ce34c08b4a05ed60e055"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.17/anythink-osx-x64"
      sha256 "e0435d21e96141791a8cb64348c66c5422833da5359b9c5f3687cec1009dede2"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.17/anythink-mcp-osx-x64"
        sha256 "af7736db677d795a859155a758f8e3d5ded83f0842fd8e81bcab414e58974c8c"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.17/anythink-linux-arm64"
      sha256 "a5e261024af31aef92b45ff2b5d57aace616d87e59cb2dbb7c15a891ce560ea0"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.17/anythink-mcp-linux-arm64"
        sha256 "b122a59f90ff90de8310f98a88b5d384bf21a5ae8ef34d083e43810213e6976f"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.17/anythink-linux-x64"
      sha256 "4f2d20815080165d4bab75a50aaa9d1cd389eaee8a417f69c03f0724ae080970"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.17/anythink-mcp-linux-x64"
        sha256 "1d947b22b2faa362af7b7a908619583e9f9b2229439f5c21fd626f177478059a"
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
