# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'IOSUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for IOSUI
  pod 'Masonry'


  target 'IOSUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'IOSUIUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "17.5"
    end
  end
end