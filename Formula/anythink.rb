class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-osx-arm64"
      sha256 "7911b7e3d34be7f37aa33f0e0f5dbdca65e39805aaf458d090511adc53786b8c"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-osx-arm64"
        sha256 "46b5c6ff5f3b7fbc602ec5894709c2a241925b6df6f09697a87272c01e46f457"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-osx-x64"
      sha256 "ed9eca8e46ecbee3ef77b903edb4c012b69e265bca0a770969a055ab30cddb83"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-osx-x64"
        sha256 "78b8f60fc3e87ad3ef72a4a6884ea725c9adeaedb5d13bc9dfe1ec7a48147c3f"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-linux-arm64"
      sha256 "7f599376c2c4f26079f0f99a9b5197264deb85c0fe2f33671386ad588a48d6ec"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-linux-arm64"
        sha256 "0b2724d206c300e9193aa3cd091bef7881833335df87e402a458e54196b43e28"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-linux-x64"
      sha256 "2a1fc387ba329fa19e695ecb97561e82dd3612b37f499c8f3ba371254287ca3a"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-linux-x64"
        sha256 "2dc7a91a720595c298e9b702d1ec30683dee85324cec0ab68459ec13280349c5"
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
