#
# Be sure to run `pod lib lint ShakeFeedback.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ShakeFeedback'
  s.version          = '0.0.1'
  s.summary          = 'Shake Feedback Bug.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
												Shake Feedback Bug
												一个帮助用户快捷反馈Bug的框架
                       DESC

  s.homepage         = 'https://github.com/yiios/ShakeFeedback'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Limo' => 'limo@yiios.com' }
  s.source           = { :git => 'https://github.com/yiios/ShakeFeedback.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ShakeFeedback/**/*'
  
  s.resource_bundles = {
    'ShakeFeedback' => ['ShakeFeedback/**/*.{storyboard,xib,ttf}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
