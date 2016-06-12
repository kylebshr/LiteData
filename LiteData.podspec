Pod::Spec.new do |s|
   s.name = 'LiteData'
   s.version = '0.1.0'
   s.license = 'MIT'

   s.description = "LiteData is a very small framework to make working with Core Data a little easier and swiftier. It doesn't do a lot, but it makes the basics very simple."
   s.summary = 'A very light and swifty core data stack'
   s.homepage = 'https://github.com/kylebshr/LiteData'
   s.social_media_url = 'https://twitter.com/kylebshr'
   s.author = 'Kyle Bashour'

   s.source = { :git => 'https://github.com/kylebshr/LiteData.git', :tag => s.version.to_s }
   s.source_files = 'Source/*.swift'

   s.ios.deployment_target = '9.0'

   s.requires_arc = true
end
