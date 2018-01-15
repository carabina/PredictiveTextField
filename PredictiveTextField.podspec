Pod::Spec.new do |s|
s.name             = 'PredictiveTextField'
s.version          = '0.1.0'
s.summary          = 'Good UI for your users looking for some data.'
s.homepage         = 'https://github.com/ronteq/PredictiveTextField'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Daniel Fernandez' => 'dfernandezyopla@gmail.com' }
s.source           = { :git => 'https://github.com/ronteq/PredictiveTextField.git', :tag => s.version.to_s }

s.ios.deployment_target = '10.0'
s.source_files = 'PredictiveTextField/PredictiveTextField.swift', 'PredictiveTextField/PredictiveTextFieldCell.swift'

end
