Gem::Specification.new do |s|
  s.name = 'pxindex-builder'
  s.version = '0.2.1'
  s.summary = 'Builds a Polyrex index (pxindex) XML document from ' + 
      'a YAML document or an indented list'
  s.authors = ['James Robertson']
  s.files = Dir['lib/pxindex-builder.rb']
  s.add_runtime_dependency('line-tree', '~> 0.6', '>=0.6.8')
  s.add_runtime_dependency('wordsdotdat', '~> 0.1', '>=0.1.1')
  s.add_runtime_dependency('phrase_lookup', '~> 0.1', '>=0.1.7')
  s.add_runtime_dependency('polyrex-builder', '~> 0.3', '>=0.3.0') 
  s.signing_key = '../privatekeys/pxindex-builder.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/pxindex-builder'
end
