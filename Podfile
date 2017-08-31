project 'SimpleCalendar.xcodeproj'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SimpleCalendar' do

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'JTAppleCalendar', '~> 7.0'
  pod 'ActionSheetPicker-3.0', '~> 2.2.0'
  pod 'ModernSearchBar'
  pod 'SmileLock'
  pod 'PinCodeTextField', :git => "https://github.com/tkach/PinCodeTextField"

pod 'Realm', git: 'https://github.com/realm/realm-cocoa.git', branch: 'master', :submodules => true
pod 'RealmSwift', git: 'https://github.com/realm/realm-cocoa.git', branch: 'master', :submodules => true

  target 'SimpleCalendarTests' do
    inherit! :search_paths
    pod 'JTAppleCalendar', '~> 7.0'
    # Pods for testing
  end

  target 'SimpleCalendarUITests' do
    inherit! :search_paths
    pod 'JTAppleCalendar', '~> 7.0'
    # Pods for testing
  end
  
end