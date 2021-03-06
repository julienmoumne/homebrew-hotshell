class Hs < Formula
  desc "Command-line application to efficiently recall and share commands"
  homepage "https://julienmoumne.github.com/hotshell"
  url "https://github.com/julienmoumne/hotshell/archive/v0.5.0.tar.gz"
  sha256 "1cdf3539bea7fa269625f4ec382f0519313cb8c2bc1e138a4088290ddf813501"

  head "https://github.com/julienmoumne/hotshell.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/julienmoumne"
    ln_s buildpath, buildpath/"src/github.com/julienmoumne/hotshell"
    system "go", "build", "-o", bin/"hs", "./src/github.com/julienmoumne/hotshell/cmd/hs"
    man1.install "./debian/usr/share/man/man1/hs.1.gz"
  end

  test do
    out = `#{bin}/hs --generate-demo --default`
    assert out.start_with?("<!DOCTYPE html>")
  end
end
