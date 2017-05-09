Pod::Spec.new do |s|
  s.name             = 'RxTableAndCollectionView'
  s.version          = '1.0.8'
  s.summary          = 'Reactive UITableView'
  s.description      = <<-DESC
An RxSwift implementation that helps eliminate boilerplate when creating and populating TableViews and CollectionViews
			DESC

  s.homepage         = 'https://github.com/devgabrielcoman/RxTableAndCollectionView'
  s.license          = { :type => 'GNU GENERAL PUBLIC LICENSE Version 3', :file => 'LICENSE' }
  s.author           = { 'devgabrielcoman' => 'dev.gabriel.coman@gmail.com' }
  s.source           = { :git => 'https://github.com/devgabrielcoman/RxTableAndCollectionView.git', :tag => '1.0.0' }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'RxSwift', '3.1.0'
  s.dependency 'RxCocoa', '3.1.0'
end
