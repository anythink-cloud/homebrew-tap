class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.36"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.36/anythink-osx-arm64"
      sha256 "5f3172aa12cf6f6e4997a9051ce3363ff158e64c0668f510fc7c7692c47a5441"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.36/anythink-mcp-osx-arm64"
        sha256 "1848d117f4dd38eb86d7df2cb13c5b340fdb0bf746418f162628103e1f669332"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.36/anythink-osx-x64"
      sha256 "dcaa5b40f7a81c7229884020ff35263695b2e7391b7d510914cab10ea5d6e71f"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.36/anythink-mcp-osx-x64"
        sha256 "57de29f643d8b551d74b8e7d00d0ecf1e8b61a92534fcd17be89971ddf40f19a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.36/anythink-linux-arm64"
      sha256 "f903b01a0ed26fc34223406410126616fbe329ac9e5d7aac1f2d7ee19c35daab"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.36/anythink-mcp-linux-arm64"
        sha256 "e74346ea4a387f55b95cd205a90dda8cdd35e62ef5c0cddd0aa5164dd148b403"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.36/anythink-linux-x64"
      sha256 "de6aefa40cd1d2d77d29069a5e6a56eef058af44421a5af37bcd3540c4d05cf2"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.36/anythink-mcp-linux-x64"
        sha256 "972b3d304fe74186b928d7fd6fc2e21d56a847c988513ae4b3fa93b6c70304f6"
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
