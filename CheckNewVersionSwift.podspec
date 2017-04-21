
Pod::Spec.new do |s|
  s.name         = "CheckNewVersionSwift"
  s.version      = "0.0.1"
  s.summary      = "This is a simple check version"
  s.homepage     = "https://github.com/MagicCodeboy/CheckNewVersion"
  s.license      = "MIT"
  s.author       = { "全聚星" => "18668460187@163.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/MagicCodeboy/CheckNewVersion.git", :tag => "0.0.1" }
  s.source_files  =  "CheckNewVersion/*"
  s.framework  = "NSObject"
  s.requires_arc = true
end
