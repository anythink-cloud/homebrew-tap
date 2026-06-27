class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.14"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.14/anythink-osx-arm64"
      sha256 "670fb01ede0f58ac4bb565fd451766f265b1ed59e0aabcd6432aa18a8a65dd2d"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.14/anythink-mcp-osx-arm64"
        sha256 "0cc75a9a13884df57e3f20da9025e0376bbf4457cca7cb45b0a9f520cdf0a848"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.14/anythink-osx-x64"
      sha256 "ec54acf849d54fd0cc0b302bd56b796488ae94b93f23b2e633b0cdff00a3c90e"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.14/anythink-mcp-osx-x64"
        sha256 "055ac8beee313c8cc544a88970e9821ee63b9f2bbac4c2a9d025fc19db2c7427"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.14/anythink-linux-arm64"
      sha256 "e69a3bf1754be16128329837e505b398d7c9136a009512d513f2b4eb3b17a8ee"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.14/anythink-mcp-linux-arm64"
        sha256 "478318ddb95b8c898dc83984e92c839b25aa2c9e15a2a1591838c4f6167f15bd"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.14/anythink-linux-x64"
      sha256 "44190af73c4189884ab927a4321b587678e8d7b1bcde686a0793d59b7ee52f1f"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.14/anythink-mcp-linux-x64"
        sha256 "6017295bab728963e371e56b23dedddd5a5209cc5fca2bbb2a875295d042ab83"
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
