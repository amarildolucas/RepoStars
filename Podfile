platform :ios, '13.0'
use_frameworks!

def shared_tests
	pod 'KIF', :configurations => ['Debug']
	pod 'Nimble'
	pod 'Quick'
end

target 'RepoStars' do
	pod 'SnapKit', '~> 5.0.0'
end

target 'RepoStarsTests' do
	inherit! :search_paths

	shared_tests
end

target 'RepoStarsAsyncTests' do
	inherit! :search_paths
	
	shared_tests
end
