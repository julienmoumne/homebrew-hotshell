require "language/go"

class Hs < Formula
  desc "Command-line application to efficiently recall and share commands"
  homepage "https://julienmoumne.github.com/hotshell"
  url "https://github.com/julienmoumne/hotshell/archive/v0.2.0.tar.gz"
  sha256 "dc020f5ad7950780f4a079ae1f677e0775e7fe953fff5fd7b41881a99072f8dd"

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
