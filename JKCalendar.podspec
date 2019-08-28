
Pod::Spec.new do |s|

  s.name             = "JKCalendar"
  s.version          = "1.1.4"
  s.summary          = "A calendar view"

  s.description      = "Calendar For ios"

  s.homepage         = "https://github.com/JoeCiou/JKCalendar"

  s.license          = 'MIT'
  s.author           = { "JoeCiou" => "joeciou810@gmail.com" }
  s.source           = { :git => "https://github.com/JoeCiou/JKCalendar.git", :tag => "1.1.4" }

  s.ios.deployment_target = '8.0'
  s.platform     = :ios, '9.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }
  s.frameworks = 'UIKit'
  s.dependencies 'JKInfinitePageView', '1.1.0'
  
  end
