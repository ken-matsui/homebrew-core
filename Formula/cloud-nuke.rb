class CloudNuke < Formula
  desc "CLI tool to nuke (delete) cloud resources"
  homepage "https://gruntwork.io/"
  url "https://github.com/gruntwork-io/cloud-nuke/archive/v0.1.26.tar.gz"
  sha256 "0feca585536de0470c0aa1e0371d0e4726770508e639ef2f1e2c0b619df04829"
  license "MIT"
  head "https://github.com/gruntwork-io/cloud-nuke.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b9b0004c478661abde73731d1992f4d0be499964b7e21f435612a2655401c5c9"
    sha256 cellar: :any_skip_relocation, big_sur:       "5dfbb61a88d7f98ee1a62a879f4b5b4b454a589e5075c883a65bc934e240c5b2"
    sha256 cellar: :any_skip_relocation, catalina:      "b70ad8545d3392c26958d9c390f2d92ab2e4530e8b925251d39a27e4bfa47f78"
    sha256 cellar: :any_skip_relocation, mojave:        "09d0f6c97b54c100956763b6418a3419ceedf4e55838b3954d19d1ffdf9aaf07"
  end

  depends_on "go" => :build

  # remove in next release
  patch do
    url "https://github.com/chenrui333/cloud-nuke/commit/5f2919c.patch?full_index=1"
    sha256 "049a8e9dfc5715c8cb322b53ea76f17192ba46342a0d09cd39d78324ba138cfa"
  end

  def install
    system "go", "build", "-ldflags", "-s -w -X main.VERSION=v#{version}", *std_go_args
  end

  def caveats
    <<~EOS
      Before you can use these tools, you must export some variables to your $SHELL.
        export AWS_ACCESS_KEY="<Your AWS Access ID>"
        export AWS_SECRET_KEY="<Your AWS Secret Key>"
        export AWS_REGION="<Your AWS Region>"
    EOS
  end

  test do
    assert_match "A CLI tool to nuke (delete) cloud resources", shell_output("#{bin}/cloud-nuke --help 2>1&")
    assert_match "ec2", shell_output("#{bin}/cloud-nuke aws --list-resource-types")
  end
end
