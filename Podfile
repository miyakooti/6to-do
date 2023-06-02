# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target '6 to-do' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for 6 to-do
  pod 'SwiftReorder'
  pod 'IQKeyboardManagerSwift'
  pod 'Google-Mobile-Ads-SDK'
end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
