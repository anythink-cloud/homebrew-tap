class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.8/anythink-osx-arm64"
      sha256 "5728b3a144a4ae8c95d58ce782e47b03547cebf3a5dc28ce8e87d1a65c936c17"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.8/anythink-mcp-osx-arm64"
        sha256 "9a6244f6f3f821e384686490e3dea84e5272cadc6d36f3cb38c3b4db4ba7a11a"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.8/anythink-osx-x64"
      sha256 "625b5a380a8a6bb5fe0c473634813eaafcf14ba7416fc908c04626414c51ef50"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.8/anythink-mcp-osx-x64"
        sha256 "aec2094f151b6cd03511eafe93e6351b2bb3b99572b7e5a7f8f2681177a53637"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.8/anythink-linux-arm64"
      sha256 "836d93d7d1ca2fa534b15f3e58b2c5745efa32ce2980195ac08feb769944bdef"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.8/anythink-mcp-linux-arm64"
        sha256 "fbb0a15cb19c7ba912588cd92c700f7d9a2dae104873c62be32a8e9c769aa636"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.8/anythink-linux-x64"
      sha256 "dc62e2eb44ab7c485d1d839c93e50eeaa8543aac79d724b77bc2fd1a8c162ec8"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.8/anythink-mcp-linux-x64"
        sha256 "e16ee89041a23ab8d74556b2dcdc2225b888a3b28a0c723c7d9cc73d8e05094d"
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
