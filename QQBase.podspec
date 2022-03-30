#
# Be sure to run `pod lib lint QQBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QQBase'
  s.version          = '1.0.1'
  s.summary          = 'A short description of QQBase.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Miaolegemi9527/QQBase'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mr.Q' => '2806671013@qq.com' }
  s.source           = { :git => 'https://github.com/Miaolegemi9527/QQBase.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'QQBase/Classes/**/*'
  
  # s.resource_bundles = {
  #   'QQBase' => ['QQBase/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  # Pod 第三方库全写在这
  # 网络请求
  s.dependency 'AFNetworking'
  # 下拉刷新上拉加载
  s.dependency 'MJRefresh'
  # 图片加载
  s.dependency 'SDWebImage'
  s.dependency 'YYWebImage'
  # 空白提示页 https://www.jianshu.com/p/6d5755a63c24
  s.dependency 'DZNEmptyDataSet'
    
end
