class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.16"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.16/anythink-osx-arm64"
      sha256 "703607cf742580ead5196959c2beba98e9fba4747cb1e732fa34fe660fe72dc1"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.16/anythink-mcp-osx-arm64"
        sha256 "8eae9df8230a1b8c24ea09e7211d8cf2bbeadf6be0a5e2e34ebcda634843f225"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.16/anythink-osx-x64"
      sha256 "ea36e8ce6411272f0c3b3fa4084a139824e6fcb7798d6df339d7ad97e4a8427d"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.16/anythink-mcp-osx-x64"
        sha256 "9d90a158af9c720144c73e70bda5e44c802df6899137c14704305ff78aff275c"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.16/anythink-linux-arm64"
      sha256 "230f231468e276a9b48da733e2d8214a0ed270aab4b46f203c7456053efdcc5a"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.16/anythink-mcp-linux-arm64"
        sha256 "3c171d6e00e9eb9a4af06d7501d15293728ee42557396de5a264569689a94974"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.16/anythink-linux-x64"
      sha256 "3b69fd28f3ef681a53cac3d895a99e8b0760597ed7823c42ab64e0a58ca1331f"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.16/anythink-mcp-linux-x64"
        sha256 "8dfb5be3ab66718c2498ab04f4c197072699509f068684169c942a92606cd0ad"
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
