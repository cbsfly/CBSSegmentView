Pod::Spec.new do |s|
  s.name         = "CBSSegmentView"
  s.version      = "1.0.0"
  s.summary      = "segmentview in iOS"

  s.description  = <<-DESC
		   this is a segmentview in iOS.
                   DESC

  s.homepage     = "https://github.com/cbsfly/CBSSegmentView"
  s.license      = "MIT"
  s.author             = { "cbsfly" => "cbs_950320@qq.com" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/cbsfly/CBSSegmentView.git", :tag => "0.1.0" }

  s.source_files  = "cbsSegmentView/Source/**/*.{h,m}"
  # s.public_header_files = "Classes/**/*.h"
  s.frameworks = 'UIKit'
end
