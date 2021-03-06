#
#  Be sure to run `pod spec lint ZJModuleCommon.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "ZJModuleCommon"
  spec.version      = "1.0.8"
  spec.summary      = "A short"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC 
                               ZJModuleCommon 是一个用于保存一些常用工具类的工具
                        DESC

  spec.homepage     = "https://github.com/gnaw9258wp/ZJModuleCommon"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "王鹏" => "1520770071@qq.com" }
  # Or just: spec.author    = "王鹏"
  # spec.authors            = { "王鹏" => "1520770071@qq.com" }
  # spec.social_media_url   = "https://twitter.com/王鹏"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # spec.platform     = :ios
  spec.platform     = :ios, "8.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "8.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/gnaw9258wp/ZJModuleCommon", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  =  "ZJModuleCommon/ZJModuleCommon/Class/ZJModuleCommon.h"
  spec.subspec 'ZJMediator' do |ss|
      ss.source_files = 'ZJModuleCommon/ZJModuleCommon/Class/ZJMediator/*.{h,m}'
  end

  spec.subspec 'Define' do |ss|
      ss.source_files = 'ZJModuleCommon/ZJModuleCommon/Class/Define/*.{h,m}'
  end

  spec.subspec 'ZJSetAuthManager' do |ss|
      ss.source_files = 'ZJModuleCommon/ZJModuleCommon/Class/ZJSetAuthManager/*.{h,m}'
      ss.dependency 'ZJModuleCommon/Define'
  end

  spec.subspec 'Category' do |ss|
      ss.source_files = 'ZJModuleCommon/ZJModuleCommon/Class/Category/**/**/*.{h,m}'
      ss.dependency 'JKCategories', '~> 1.9'
  end

  spec.subspec 'Environment' do |ss|
      ss.source_files = 'ZJModuleCommon/ZJModuleCommon/Class/Environment/*.{h,m}'
  end

  spec.subspec 'BaseVC' do |ss|
      ss.source_files = 'ZJModuleCommon/ZJModuleCommon/Class/BaseVC/*.{h,m}'
      ss.dependency 'ZJModuleCommon/Category'
      ss.dependency 'ZJModuleCommon/Define'
  end

  spec.subspec 'ZJHUD' do |ss|
      ss.source_files = 'ZJModuleCommon/ZJModuleCommon/Class/ZJHUD/*.{h,m}'
      ss.dependency 'ZJModuleCommon/Category'
      ss.dependency 'ZJModuleCommon/Define'
      ss.dependency 'MBProgressHUD', '~> 1.1.0'
      ss.resources = "ZJModuleCommon/ZJModuleCommon/Class/ZJHUD/*.{xib,bundle,xcassets,html,plist,js,json,gif}"
  end

  spec.subspec 'ZJNavigationController' do |ss|
      ss.source_files = 'ZJModuleCommon/ZJModuleCommon/Class/ZJNavigationController/*.{h,m}'
      ss.dependency 'ZJModuleCommon/Category'
  end

  spec.subspec 'ZJNetWork' do |ss|
      ss.source_files = 'ZJModuleCommon/ZJModuleCommon/Class/ZJNetWork/*.{h,m}'
      ss.dependency 'ZJModuleCommon/Environment'
      ss.dependency 'ZJModuleCommon/Category'
      ss.dependency 'YTKNetwork', '~> 2.1.4'
      ss.dependency 'Reachability', '~> 3.2'
  end

  spec.subspec 'Tool' do |ss|
      ss.source_files = 'ZJModuleCommon/ZJModuleCommon/Class/Tool/*.{h,m}'
      ss.dependency 'AFNetworking'
  end

  #spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"
  # spec.prefix_header_contents = '#import "ZJPrefixHeader.pch"'

  # spec.prefix_header_contents = '#import "ZJPrefixHeader.pch"'

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"
  # spec.resources = ['ZJModuleCommon/ZJModuleCommon/Class/ZJHUD/MBProgressHUD+JDragon.bundle']
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"
  spec.dependency 'Masonry', '~> 1.1.0'
  spec.dependency 'SDWebImage', '~> 5.0'
end
