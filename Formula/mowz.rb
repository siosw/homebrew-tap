class Mowz < Formula
  desc "mowz retrieves production context"
  homepage "https://github.com/siosw/mowz"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/siosw/mowz/releases/download/v0.1.1/mowz-aarch64-apple-darwin.tar.xz"
      sha256 "cf17f75d57583b26b892020e90da8e19495f49b5f9426ebf8cf0733418f5b6c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siosw/mowz/releases/download/v0.1.1/mowz-x86_64-apple-darwin.tar.xz"
      sha256 "31e6a874a26a3b257753e8cf4286d4b84e83a93cefafee6ee19e48be6f27579d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/siosw/mowz/releases/download/v0.1.1/mowz-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca20e9a66d6a51bfa54d677c6d925e22789d848863cdcef6f840b07733e86b65"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siosw/mowz/releases/download/v0.1.1/mowz-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0c92bdcdce21d27d721b4ea77c065fd021fb40771dbb80d627e4f89c6d178489"
    end
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "mowz"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mowz"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mowz"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mowz"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
