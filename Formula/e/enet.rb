class Enet < Formula
  desc "Provides a network communication layer on top of UDP"
  homepage "http://enet.bespin.org"
  url "http://enet.bespin.org/download/enet-1.3.18.tar.gz"
  sha256 "2a8a0c5360d68bb4fcd11f2e4c47c69976e8d2c85b109dd7d60b1181a4f85d36"
  license "MIT"
  head "https://github.com/lsalzman/enet.git", branch: "master"

  livecheck do
    url "http://enet.bespin.org/Downloads.html"
    regex(/href=.*?enet[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "de387a32a1ecaf84c7a6613ad9e52db6240d039dca24c4aad198340517b0c75f"
    sha256 cellar: :any,                 arm64_ventura:  "8ffd8e1ae66e88e051ccd64b6d74522d02eeb1b096fcbcc022f86f083b8810f0"
    sha256 cellar: :any,                 arm64_monterey: "b3062174516e707b28107908022121945529e208ca2e7373816cfc3c8799e838"
    sha256 cellar: :any,                 arm64_big_sur:  "b2ef2e83fc0f527691e8352d39241277ab742569cc5278a357a53b19a42e700d"
    sha256 cellar: :any,                 sonoma:         "d58d67c6b940adcea2dd7e906309085d548dca0ff305f1f2c490857369357358"
    sha256 cellar: :any,                 ventura:        "876cfcfa8008a761b85007f72a6644828ab6d8ac752ed303d98abcf42595837b"
    sha256 cellar: :any,                 monterey:       "4f4c90156aae2b0d4b0ac10863a6be5fe65350f047b7607f46c71e391aa59088"
    sha256 cellar: :any,                 big_sur:        "bb861ad42df5152ac53708cdee14a599ff5e09a06cf3d438e88f7bc6b84590db"
    sha256 cellar: :any,                 catalina:       "557052d4c6fb7e8c4329270730bd97b032f279c2cfafaa6ebbd32f7ff7e076bf"
    sha256 cellar: :any,                 mojave:         "7df13b64c909df3368a91094abaaab1563f66ebcb276af0d318408977af08d2f"
    sha256 cellar: :any,                 high_sierra:    "6fbf495f25b1df30003129b77167df08d26fbb576fa61a3f17ff7eba366bdd2a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f0531f7c9cb6c994d6a38b07ac6e303f81a8a4194dd7daaa6d6aec1d25155afb"
  end

  def install
    system "./configure", *std_configure_args.reject { |s| s["--disable-debug"] }
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <enet/enet.h>
      #include <stdio.h>

      int main (int argc, char ** argv)
      {
        if (enet_initialize () != 0)
        {
          fprintf (stderr, "An error occurred while initializing ENet.\\n");
          return EXIT_FAILURE;
        }
        atexit (enet_deinitialize);
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lenet", "-o", "test"
    system testpath/"test"
  end
end
