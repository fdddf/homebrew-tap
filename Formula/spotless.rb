# A binary formula: the release ships one universal Mach-O built and published
# by the project's own CI, so there is nothing to compile here and no bottle to
# pour. `brew audit --strict` will note the lack of a build; that is expected
# for a tap distributing a prebuilt release artifact.
class Spotless < Formula
  desc "Fast, transparent macOS cleaner for the terminal, with a TUI"
  homepage "https://github.com/fdddf/spotless-cli"
  url "https://github.com/fdddf/spotless-cli/releases/download/v0.1.2/spotless-macos-universal.tar.gz"
  sha256 "986b8bda1e0a4c704e52b57411862c4c122dfab3b333945d4268419cc5b12baa"
  license "GPL-3.0-or-later"
  version "0.1.2"

  depends_on :macos

  def install
    bin.install "spotless"
  end

  test do
    assert_match "spotless #{version}", shell_output("#{bin}/spotless --version")
    # `rules` prints the compiled-in ruleset and touches nothing on disk, which
    # makes it the one command that is always safe to run inside a sandbox.
    assert_match "targets", shell_output("#{bin}/spotless rules")
  end
end
