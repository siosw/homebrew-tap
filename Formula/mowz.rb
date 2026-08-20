class Mowz < Formula
  desc "mowz retrieves production context"
  homepage "https://github.com/siosw/mowz"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/siosw/mowz/releases/download/v0.1.0/mowz-aarch64-apple-darwin.tar.xz"
      sha256 "3386a30f00fc342d493925d9e515dca331b32fcb21d79bc309fbc004a6d9de4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siosw/mowz/releases/download/v0.1.0/mowz-x86_64-apple-darwin.tar.xz"
      sha256 "e087b67c4387c75116da7b19199f44ac08641a44e8b1872b1518bb493526e280"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/siosw/mowz/releases/download/v0.1.0/mowz-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "27427b713e674d8987bf15e71a4d33780e72d6741dbed98815680bbd59e39398"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siosw/mowz/releases/download/v0.1.0/mowz-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e5d4b2af62369cc4781a62af46049edb72f49e244524eb18799f23cba078a369"
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
