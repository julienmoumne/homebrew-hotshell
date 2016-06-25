require "language/go"

class Hs < Formula
  desc "Command-line application to efficiently recall and share commands"
  homepage "https://julienmoumne.github.com/hotshell"
  url "https://github.com/julienmoumne/hotshell/archive/v0.1.0.tar.gz"
  sha256 "0ee2f8385c8eb7a2e858071317e67ea07075242a24f971c72887cf73641a4e3f"

  head "https://github.com/julienmoumne/hotshell.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/julienmoumne"
    ln_s buildpath, buildpath/"src/github.com/julienmoumne/hs"
    system "go", "build", "-o", bin/"hs", "./src/github.com/julienmoumne/hs/cmd/hs"
    man1.install "./debian/usr/share/man/man1/hs.1.gz"
  end

  test do
    out = `#{bin}/hs --generate-demo --default`
    assert out.start_with?("<!DOCTYPE html>")
  end
end
