
Pod::Spec.new do |s|

  s.name         = "JKCalendar"
  s.version      = "1.1.4"
  s.summary      = "A calendar view"

  s.description  = "Calendar For ios"
  s.homepage     = "https://github.com/JoeCiou/JKCalendar"
  s.license      = { :type => "MIT" }
  s.author       = { "JoeCiou" => "joeciou810@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/JoeCiou/JKCalendar.git", :tag => "1.1.4"}

  s.ios.deployment_target = '8.0'

  s.source_files  = "Sources/*.{swift,h}"
  s.resource_bundles = {
    'JKCalendar' => ['Sources/*.{xcassets,xib}']
  }
  s.frameworks = 'UIKit'
  s.dependencies = 'JKInfinitePageView'
end
