Pod::Spec.new do |s|
  s.name             = 'ConcentricProgressRingView'
  s.version          =  "2.0.2"
  s.summary          = 'Fully customizable circular progress bar written in Swift'
  s.homepage         = 'https://github.com/lionheart/ConcentricProgressRingView'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Dan Loewenherz' => 'dan@lionheartsw.com' }
  s.source           = { :git => 'https://github.com/lionheart/ConcentricProgressRingView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lionheartsw'

  s.ios.deployment_target = '10.3'

  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.2'
  }

  s.source_files = 'ConcentricProgressRingView/Classes/**/*'
  s.dependency 'LionheartExtensions'
end
