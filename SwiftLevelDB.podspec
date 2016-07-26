Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name = "SwiftLevelDB"
  s.summary = "Swift binding for LevelDB"
  s.requires_arc = true
  s.version = "0.1.0"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Sedat Gokbek CIFTCI" => "me@sedat.ninja" }
  s.homepage = "http://sedat.ninja"
  s.source = { :git => "https://github.com/0x73/SwiftLevelDB", :tag => "#{s.version}"}
  s.framework = "UIKit"
  s.framework = "Foundation"
  s.dependency 'leveldb-library', '~> 1.18'
  s.source_files = "SwiftLevelDB/**/*.{swift,h,mm,m}"
end
