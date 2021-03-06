lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "wfl_simple_activity/version"

Gem::Specification.new do |spec|
  spec.name          = "wfl_simple_activity"
  spec.version       = WflSimpleActivity::VERSION
  spec.authors       = ["longhaoran"]
  spec.email         = ["longhr@wfl-ischool.cn"]

  spec.summary       = "使用public_activity记录数据变化"
  spec.description   = "简易的采用public activity记录数据变化的gem"
  spec.homepage      = "https://github.com/LongLonghaoran/wfl_simple_activity"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/LongLonghaoran/wfl_simple_activity"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.add_dependency "public_activity"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end