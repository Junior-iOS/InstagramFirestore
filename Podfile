# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'InstagramFirestore' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end

  # Pods for InstagramFirestore

  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'
  pod 'Firebase/Messaging'
  pod 'Firebase/Auth'
  pod 'ActiveLabel'
  pod 'SDWebImage'
  pod 'JGProgressHUD'
  pod 'YPImagePicker'

end
