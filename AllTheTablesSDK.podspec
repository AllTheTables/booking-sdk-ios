Pod::Spec.new do |s|
  s.name = 'AllTheTablesSDK'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'All The Table Booking iOS SDK'
  s.homepage = 'https://github.com/AllTheTables'
  s.source = { :git => 'https://github.com/AllTheTables/booking-sdk-ios.git', :tag => s.version }
  s.authors = { 'Rich Mucha' => 'rich@richappz.com' }
  
  s.ios.deployment_target = '12.0'
  s.source_files = 'Source/**/*.{swift}'
  s.swift_versions = '5.0'

end
