class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.24"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.24/anythink-osx-arm64"
      sha256 "d47c67b3a181521aae10a9a5a849fd2025addc4dec14183541801dfbf94cb097"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.24/anythink-mcp-osx-arm64"
        sha256 "2535b6a0cf3f71a93322cd82aae2f5ce48eb04db2dac538f542e7a3a07c2b648"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.24/anythink-osx-x64"
      sha256 "f37939ba3217c3c126c7e4d7f02e5a7672674528251b6ff2b7223d31f2bb2ffa"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.24/anythink-mcp-osx-x64"
        sha256 "564d35eee2924fc5b0b8a72de945e2ab2abcd8916326bdb125161dc247cfda35"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.24/anythink-linux-arm64"
      sha256 "7105d15cd2e0216118616dff2dce430878de5a4cd6fad7258ee7f7bdbb0f7bd8"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.24/anythink-mcp-linux-arm64"
        sha256 "22a8445586f054feb80742f70735fede7b179e9e633193219fb0b48ad1e29880"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.24/anythink-linux-x64"
      sha256 "eea9174a0f693dce6078e85686cbbb765ca99a06a9e81c29d8aadc91ed4cd674"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.24/anythink-mcp-linux-x64"
        sha256 "bdff809f6ee6609d835a9f640a1122414edd67ac56c1478ffa71a5bee1c9fe48"
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
