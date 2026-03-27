class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-osx-arm64"
      sha256 "5b3ba9a8673c0de950add604cda323a284ce5971877cb1c28a927ebd6e34cb6f"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-osx-arm64"
        sha256 "b86f189a8aa467071c761e5e21384d4689a910fb8882bc4dc90292a92efb938a"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-osx-x64"
      sha256 "67ce9559dc31b94001711e7791dc20b77a5d170d9886e8cd0e560f1103a90325"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-osx-x64"
        sha256 "bd69cfc589827534bd3e97e3bd6e0196de23728f246767113d9dedb2265d5fcb"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-linux-arm64"
      sha256 "10d9bdb45723eee5a75de41a0f8ab13e5074d2ff17b24792f210e41bd720ef96"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-linux-arm64"
        sha256 "e1b43ccb180a97a7795fd1a11133844b8bb11366e512d4149d26047ba21b3d19"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-linux-x64"
      sha256 "bdf211b926bd0f4d9325d06dbced0d1795b7195f4b60b69cae73bc0563debff8"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.0/anythink-mcp-linux-x64"
        sha256 "7099d79a383993253cdd77401dd53303ff2b65c53590fac74f7cb0939f6b27bf"
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
