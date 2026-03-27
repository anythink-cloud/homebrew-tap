class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-osx-arm64"
      sha256 "b9b17523a39a25665ee1a19fbecbaac75b55e626f0af319b6b2e1f97743e8048"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-osx-arm64"
        sha256 "24fdf68d70e1ddbbd628ccb77073354de19e0a7519c94f3302aadc24ccdf2645"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-osx-x64"
      sha256 "f4c2be468c77434ca2b0d0261b9418f54e8fc506fad027d47a1f765eefccab4b"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-osx-x64"
        sha256 "eba8d8e2e1622d8c110b075e5614ebfc8716a4e516a79d8db61cba0f88540e07"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-linux-arm64"
      sha256 "1aa569cc77d394b210130acc6400d9e8e75fff2e35a3be2da813c608c1f6bb25"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-linux-arm64"
        sha256 "bb737829fbe84f1d7d93d201f3a0004fa336f2bb453e8ec60af317ae3ed4c844"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-linux-x64"
      sha256 "50f2f31e5d6e6f2393f4df96eaba200bef59ffa74275158e3164bfca5daae572"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-linux-x64"
        sha256 "c07957a5659b2c1c2961fa22dc3beb6baba08f7001a7384cd338958c7cd5cb95"
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
    banner = <<~'ART'
         ░███                             ░██    ░██        ░██           ░██
        ░██░██                            ░██    ░██                      ░██
       ░██  ░██  ░████████  ░██    ░██ ░████████ ░████████  ░██░████████  ░██    ░██
      ░█████████ ░██    ░██ ░██    ░██    ░██    ░██    ░██ ░██░██    ░██ ░██   ░██
      ░██    ░██ ░██    ░██ ░██    ░██    ░██    ░██    ░██ ░██░██    ░██ ░███████
      ░██    ░██ ░██    ░██ ░██   ░███    ░██    ░██    ░██ ░██░██    ░██ ░██   ░██
      ░██    ░██ ░██    ░██  ░█████░██     ░████ ░██    ░██ ░██░██    ░██ ░██    ░██
                         ░██
                   ░███████
    ART
    <<~EOS
      #{banner}
      Whatever you're building, Anythink is the backend at your service.

      Get started:
        anythink login

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
