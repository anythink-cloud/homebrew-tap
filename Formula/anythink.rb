class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.31"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.31/anythink-osx-arm64"
      sha256 "78a54f542c74403e10d156f5f3beff1423a6a119ce57142567cddee0071fdd27"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.31/anythink-mcp-osx-arm64"
        sha256 "54d86399234bcdc7af9940990ae3505727ec1192f365876a4284f2a762a971c5"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.31/anythink-osx-x64"
      sha256 "d085b9ae3d69ef3f5fdd33862af5ce9c0c43ce8ce3067c4c1fbb33d068b4e80e"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.31/anythink-mcp-osx-x64"
        sha256 "0ed2bbd71683b07b16431989d3f5cc7094cdfa9ed744ffcc88d25849d6c8750f"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.31/anythink-linux-arm64"
      sha256 "9bf3a7b9b675b217d290ed0cdd74aa2f9f196e807960ec2f5c3f6b79e3b6c1c2"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.31/anythink-mcp-linux-arm64"
        sha256 "acf60c5b78a930e7e6a4b16adf828fff9e0fe863d12cd71e339731ce58c8760c"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.31/anythink-linux-x64"
      sha256 "f1ce139e44bc66c0406f5d53d3347033845a90a87a4d44d8ef776761990da564"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.31/anythink-mcp-linux-x64"
        sha256 "71a43da99731a950a25b67bae3f0c89f5b26f22c1bf54ebf853affc85424855a"
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
