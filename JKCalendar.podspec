
Pod::Spec.new do |s|

  s.name         = "JKCalendar"
  s.version      = "1.1.4"
  s.summary      = "A calendar view"

  s.description  = "CreditCardForm is iOS framework that allows developers to create the UI which replicates an actual Credit Card"
  s.homepage     = "https://github.com/JoeCiou/JKCalendar"
  s.license      = { :type => "MIT" }
  s.author       = { "JoeCiou" => "joeciou810@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/JoeCiou/JKCalendar.git", :tag => "1.1.4"}

  s.ios.deployment_target = '8.0'

  s.source_files  = "Sources/*.{swift,h}"
  s.resource_bundles = {
    'CreditCardForm' => ['Sources/*.{xcassets,xib}']
  }
  s.frameworks = 'UIKit'
end
