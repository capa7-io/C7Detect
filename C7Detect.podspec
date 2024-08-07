Pod::Spec.new do |spec|
  spec.name                    = 'C7Detect'
  spec.version                 = '1.0.0'
  spec.summary                 = 'C7Detect library for iOS & macOS'
  spec.homepage                = 'https://capa7.io'
  spec.license                 = { :type => 'PROPERT' }
  spec.author                  = 'Capa7 LLC'
  spec.source                  = { :git => 'https://github.com/capa7-io/C7Detect.git', :tag => '1.0.0' }

  spec.swift_version           = '5.10'
  spec.ios.deployment_target   = '13.0'
  spec.osx.deployment_target   = '13.10'

  spec.framework               = 'Security', 'Foundation'
  spec.ios.framework           = 'UIKit'
  spec.osx.framework           = 'Cocoa'

  spec.vendored_frameworks     = 'Frameworks/C7Detect.xcframework'
  spec.preserve_paths          = 'Frameworks/C7Detect.xcframework'
end