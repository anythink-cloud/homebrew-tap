class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.20"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.20/anythink-osx-arm64"
      sha256 "3c147c4c9bb413ec4e4fb16d0990df5b1cfba1b48f4d1a27df6e405dbc3f4816"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.20/anythink-mcp-osx-arm64"
        sha256 "af3e382946c9041d23b2e64978d42e5605bbd233cfd833eb24f5d84e29c3e9c7"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.20/anythink-osx-x64"
      sha256 "0b4f36a5afe65cd05a3b7eabb71e8ddd72847b40ea04c4f6947dfdac5274a566"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.20/anythink-mcp-osx-x64"
        sha256 "8be3ad5dfde0ee283e1c2d2d0641a4430d857d18b30d2f90a67801b907a3f716"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.20/anythink-linux-arm64"
      sha256 "d53ad302fe5ce25b1b0c989a74cf311e0d42b7c342b867ebe46a86555b4ed620"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.20/anythink-mcp-linux-arm64"
        sha256 "db5330f8bfb141fcc4810c139d55d855495132887dc0ad22b24188a4be9b6ec2"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.20/anythink-linux-x64"
      sha256 "c148ee9544f130bf3bd9389725aed9445a0e5568439a88b6fb1da1af4e47bae0"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.20/anythink-mcp-linux-x64"
        sha256 "f9391acd47da6a542fe41948235866bb76d34553c9e17e2c54401495e01593d5"
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
