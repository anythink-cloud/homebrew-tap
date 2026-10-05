class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.25"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.25/anythink-osx-arm64"
      sha256 "641d41d575fe66d638b721848f15b151d509bafac2e7e466accd2c10a09379e2"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.25/anythink-mcp-osx-arm64"
        sha256 "5b2ebea2b971bedcad4998ff06143c88add2bb7112c00aec3e4607e1107df2aa"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.25/anythink-osx-x64"
      sha256 "d67c3f2ef0e3f7f8a3cc609e680d3377e858bed685e3496de9f1f2bb6e59754c"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.25/anythink-mcp-osx-x64"
        sha256 "e6010f4c158fccb60c6d14ee338ed1e102d5249aa14aaac9cd1be8ca63b5085f"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.25/anythink-linux-arm64"
      sha256 "91233eebce32974bdb12b506e7704a0c5f84d6e49c488b558153f4914c375a9a"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.25/anythink-mcp-linux-arm64"
        sha256 "0b21a902b8d3b56e2a2a1f2e967e82ffdb5dfea93793643c304fcdcd01e0b813"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.25/anythink-linux-x64"
      sha256 "f71f2a138d7a986651bffd930c6ae66d1a063dcd359eec073ee92763c29ef518"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.25/anythink-mcp-linux-x64"
        sha256 "0afc1a1f0ed19ecbac1e630bdc52320b23035f243519cb58751a808318561f64"
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
