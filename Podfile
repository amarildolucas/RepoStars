platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

def shared_tests
	pod 'Nimble'
	pod 'Nimble-Snapshots'
	pod 'Quick'
end

target 'RepoStars' do
	pod 'SnapKit', '~> 5.0.0'
end

target 'RepoStarsTests' do
	shared_tests
end

target 'RepoStarsAsyncTests' do
	shared_tests
end

target 'RepoStarsSnapshots' do
	shared_tests
end

target 'RepoStarsUITests' do
	pod 'KIF', :configurations => ['Debug']
end
