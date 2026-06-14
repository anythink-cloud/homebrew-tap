class Anythink < Formula
  desc "CLI and MCP server for the Anythink backend-as-a-service platform"
  homepage "https://github.com/anythink-cloud/anythink-cli"
  version "0.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.4/anythink-osx-arm64"
      sha256 "da14b4e007c7e16600279ce8b87ce68a2612194bda82cb40e87596894ffd8a24"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.4/anythink-mcp-osx-arm64"
        sha256 "7e34246015b1434611b9b699fdf24f5d68cfae84a049f062f8411a508546bccb"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.4/anythink-osx-x64"
      sha256 "b6697c6fcdcfc9b0d3269d1762982de1c05fe4faa4618d7705784a91a6e51c56"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.4/anythink-mcp-osx-x64"
        sha256 "52eff77d4b2500f84fba0be4e6c2c552a99c789a49ea7b35b71c2246a41f9615"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.4/anythink-linux-arm64"
      sha256 "5058b1ba51ca2dd6b2ba59aa04dd2ecf49f2b18e659814491c92f0138c084ae3"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.4/anythink-mcp-linux-arm64"
        sha256 "c7a7511c073ae933a8457916d36c717f1f20df048f95abf741d3dfc6f3532a29"
      end
    else
      url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.4/anythink-linux-x64"
      sha256 "02306b6b3dd37aff1ba8ccaf38f0328ca5af5847f25ad7cdf114bda6f7d94a9a"

      resource "mcp" do
        url "https://github.com/anythink-cloud/anythink-cli/releases/download/v0.2.4/anythink-mcp-linux-x64"
        sha256 "6e98c92f86db1111c66274d9d9b64ae1bd4b855692f71f5886b8fa716e1ac5ec"
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
