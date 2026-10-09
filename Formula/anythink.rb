class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.29"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.29/anythink-osx-arm64"
      sha256 "2746da985d3d6a2d12120cefa42af0b6dd6156fe4a25274091890ecfc0b61f5a"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.29/anythink-mcp-osx-arm64"
        sha256 "0619451c7bfc7d03eda173b4a9f9067354cce194f1d8a8a36d61780e27f8d09c"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.29/anythink-osx-x64"
      sha256 "a9ffa00acf0ab27e8dc61791ef9baf64e038e93b0cceeaeeba20ac7cca6c221f"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.29/anythink-mcp-osx-x64"
        sha256 "bbb32189e44c93879386f9da280151da55af5ed44fd13b40e15f3d2edad22b2d"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.29/anythink-linux-arm64"
      sha256 "422e2abe132eb5f27d71c999a7fb43ddcacfaa7931b90c4533fd9c556c71123b"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.29/anythink-mcp-linux-arm64"
        sha256 "7711a088c19e49040eebf1a3b64dddb6ebcfb46e2199edc1aa6e0c942a57a531"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.29/anythink-linux-x64"
      sha256 "c2356ca6240d76667ef8b9ec67f3ae93a108167de30b2394c0ff5244eab44cc9"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.29/anythink-mcp-linux-x64"
        sha256 "04d3582bcba03a8e13f26edeae46c2fdfbe6f3acd8aeac8d1f4997d849760952"
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
