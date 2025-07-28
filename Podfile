target 'MyWall' do
  use_frameworks!

  # Pods for MyWall
  # Networks
  pod 'Alamofire'
  
  # Load Image
  pod 'Kingfisher', '~> 8.0'
  
  pod 'RxSwift', '6.8.0'
  pod 'RxCocoa', '6.8.0'
  pod 'RxGesture'

  # Animation
  pod 'lottie-ios'
  
  # Firebase
  pod 'FirebaseCore', :git => 'https://github.com/firebase/firebase-ios-sdk.git',
  :tag => 'CocoaPods-10.24.0'
  pod 'FirebaseCrashlytics', :git => 'https://github.com/firebase/firebase-ios-sdk.git',
  :tag => 'CocoaPods-10.24.0'
  pod 'FirebaseAnalyticsSwift', :git => 'https://github.com/firebase/firebase-ios-sdk.git',
  :tag => 'CocoaPods-10.24.0'
  pod 'FirebaseRemoteConfig', :git => 'https://github.com/firebase/firebase-ios-sdk.git',
  :tag => 'CocoaPods-10.24.0'
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'BoringSSL-GRPC'
      target.source_build_phase.files.each do |file|
        if file.settings && file.settings['COMPILER_FLAGS']
          flags = file.settings['COMPILER_FLAGS'].split
          flags.reject! { |flag| flag == '-GCC_WARN_INHIBIT_ALL_WARNINGS' }
          file.settings['COMPILER_FLAGS'] = flags.join(' ')
        end
      end
    end
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
    end
  end
end
