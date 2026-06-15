class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.12"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.12/anythink-osx-arm64"
      sha256 "d45b7abaa2e1f80b223cacdb12a14876fdded60d7681afcf2e89f594026e65b9"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.12/anythink-mcp-osx-arm64"
        sha256 "6018f3917e00c73e3fba46b1d3b6d20b0e0abf37b40fd7a2500b19ce9eeade96"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.12/anythink-osx-x64"
      sha256 "527ab888208dfcac1d163f42e8859ff99800dea53087b95e333a9aa4f5395012"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.12/anythink-mcp-osx-x64"
        sha256 "ab4cc9bd739e4e60de2c700d1490a51bc3207bba42714631714be7e9215e7bf2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.12/anythink-linux-arm64"
      sha256 "a5aadd5630f27812c877ca50c6f35cbc0aab66b4d0d872a789ec452e134b99f5"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.12/anythink-mcp-linux-arm64"
        sha256 "ad4537b2f3fc0291b9454a9c33a06b60d688ed76547c9543161c835430f2ff07"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.12/anythink-linux-x64"
      sha256 "51f49349b14749b6e5989da49a87146a2e56a22f10cd5966be6e29a8ab11f624"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.12/anythink-mcp-linux-x64"
        sha256 "cf89536df1083e7e617a344533ac4c00231ae1c42891462794c39d16c092982e"
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
