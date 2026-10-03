class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.22"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.22/anythink-osx-arm64"
      sha256 "a81c463d3aa6da81825709483050b4445e5972d64f9671c84efefe4193df4c7a"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.22/anythink-mcp-osx-arm64"
        sha256 "cf2c86247530f8af63bf18490140cb0d0de2489af342e2c5362948b09565b0e1"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.22/anythink-osx-x64"
      sha256 "8f3ff73718c9f12384be4ddd0cd48144e0a841c509e7a54f83bdb9a2ff64e7a2"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.22/anythink-mcp-osx-x64"
        sha256 "cc88d30938131f8817ca1b9edc45b1940d6db21b679fc9ce6221ecde39005cfd"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.22/anythink-linux-arm64"
      sha256 "eefd384f198cf333456294122251f52d418fb979e68dd9da642f3fbd478d68e8"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.22/anythink-mcp-linux-arm64"
        sha256 "834a7ae9057c0839961ffc23cbdd31789f165ce732095e39a32fa65a701a80fc"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.22/anythink-linux-x64"
      sha256 "40d6baa0f60e9a63d560e87105cb899a528d4be5d90ff7ce2f8fef9c488d4926"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.22/anythink-mcp-linux-x64"
        sha256 "41d68aa33f8aa187dcbb454725be8023a8c28acfd3a1366fcb4f837be6c7c17f"
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
