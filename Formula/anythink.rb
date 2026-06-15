class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.11/anythink-osx-arm64"
      sha256 "6ff7a83eb3e480afb0242a4f85682744cc431b0f7bf8be4b1d8e46f69ad9a43b"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.11/anythink-mcp-osx-arm64"
        sha256 "cf046284ae0c8455c98a64483bc754ceb982ab85716a7d3ebd27cb004c967290"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.11/anythink-osx-x64"
      sha256 "e2669562010de9388578983247b02b2ebc32d2a7826074e7ea15944e2ae02046"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.11/anythink-mcp-osx-x64"
        sha256 "7a87e05e36e08398d3859b0d5a1c3756e7feb281ce64adb0e509c1b390aa350e"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.11/anythink-linux-arm64"
      sha256 "484c6e332056ccf886ccc1f0bce6e507b32299ca71485f16ce831531092b8e38"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.11/anythink-mcp-linux-arm64"
        sha256 "66c037b63cd3d6713c4231b8caa8717b7b1a3e90de63a7d3f214c3275a2076a7"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.11/anythink-linux-x64"
      sha256 "642ae40aec67e82055a59e05359e265bccd03d5d217c7d819ad40ec32d30eed8"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.11/anythink-mcp-linux-x64"
        sha256 "878f18e1ced9d246eba67b38282c6c276e5a5c19e900e3c3712869696aa46de0"
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
