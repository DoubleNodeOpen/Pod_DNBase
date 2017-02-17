source 'git@github.com:DoubleNodeOpen/CocoapodsSpecsRepo.git'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

inhibit_all_warnings!

platform :ios, '9.0'

target 'DNBase' do
  # Pods for DNBase
  pod 'AFNetworking', '~> 3.0'
  pod 'ColorUtils'

  target 'DNBaseTests' do
    inherit! :search_paths

    # Pods for testing
    pod 'Gizou', :git => "git@github.com:doublenode/Gizou.git"
    pod 'OCMock'
  end

end
