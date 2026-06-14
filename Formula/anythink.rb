class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.9/anythink-osx-arm64"
      sha256 "34cbb054cc4f6d3b3a7f42b15d456ae9dd5a162fc201bf5d3875d504b7ffda45"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.9/anythink-mcp-osx-arm64"
        sha256 "f36c02b48710276f8fa09e3ccff8db9bb97569897f621eda1f4e7e68833dec4f"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.9/anythink-osx-x64"
      sha256 "fb9eba8acb0a54a292fc119d26d7c2f798537fbcd48868c618444db276ce0ea8"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.9/anythink-mcp-osx-x64"
        sha256 "0271121cba15e05e9592ab362d8d144cad5444f442929497d7b281589e0721c9"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.9/anythink-linux-arm64"
      sha256 "bd942f187773a202b1b74c915bdde2fe0e13ab7798e18f1ce741a14d3b116303"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.9/anythink-mcp-linux-arm64"
        sha256 "48cd01fea3733454c474806fc07c6fdad33d0c7ae570f7dd4b7641d0bdb084b8"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.9/anythink-linux-x64"
      sha256 "f7f7e9426ae7a38ab6a6df140236eea03fae374f1b552d54769f5f2c5eb58a90"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.9/anythink-mcp-linux-x64"
        sha256 "b181b6d21fac58a3dcbe4389cda7bb48df546aa12641afbd108a9c64ae31f5a0"
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
