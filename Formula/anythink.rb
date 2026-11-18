class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.38"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.38/anythink-osx-arm64"
      sha256 "83ffbfbcdc8a53ad26058ae077594570cff7483daa819bb32d2a1a915af39f51"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.38/anythink-mcp-osx-arm64"
        sha256 "a8d9633c44ca48ded80227e7a4ef674cbfc0095481309464a7cbf108ff64e485"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.38/anythink-osx-x64"
      sha256 "ca4c697928bbcebccf250aaf3d8fbd7d40088d36f369e7231507faacd464bb59"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.38/anythink-mcp-osx-x64"
        sha256 "99c7601dcbf91f630089ababfdb2d77f4319b99b43cb4b6055e393ec4a59a03d"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.38/anythink-linux-arm64"
      sha256 "eb25b94272a5cb2952bc05c9192c78ea6d4df5a32786c3b60c84a83f532e3e90"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.38/anythink-mcp-linux-arm64"
        sha256 "a5316e0223d33a97829a39239fce482fe1cf1895af5c50e829321ffa715f5b73"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.38/anythink-linux-x64"
      sha256 "841a3ca88e482ecf1e7eaadf7d7c559ecbae5a1255358ce05cd06c689df54149"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.38/anythink-mcp-linux-x64"
        sha256 "d18674b91d3a66ecd502bb2ae613c80da51f6f972e99ed8ef215f113364b7231"
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
