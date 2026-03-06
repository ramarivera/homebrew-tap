class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/steipete/wacli"
  version "0.2.0"
  license "MIT"
  depends_on "go" => :build

  on_macos do
    url "https://github.com/steipete/wacli/releases/download/v#{version}/wacli-macos-universal.tar.gz"
    sha256 "7c42cc5b60caeef44286bb867f235f5d8d09c24419271590d86ca8e4ef385703"
  end

  on_linux do
    url "https://github.com/ramarivera/homebrew-tap/releases/download/wacli-v0.2.0-linux-r1/wacli-linux-x86_64-v0.2.0-r1.tar.gz"
    sha256 "53b66fb92f76325acdba5ec272bdd424825737f2f7fa4be7d366833a4e03c561"
  end

  head "https://github.com/steipete/wacli.git", branch: "main"

  def install
    if File.exist?("wacli")
      bin.install "wacli"
    else
      ldflags = "-s -w -X main.version=#{version}"
      system "go", "build", "-tags", "sqlite_fts5", *std_go_args(ldflags: ldflags), "./cmd/wacli"
    end
  end

  test do
    assert_match "wacli", shell_output("#{bin}/wacli --version")
    assert_match "FTS5", shell_output("#{bin}/wacli doctor")
  end
end
