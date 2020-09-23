//
//  AppDelegate.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 23/09/20.
//

import UIKit

// MARK: - AppDelegate
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		let viewController = RepositoriesViewController()
		let navigationController = UINavigationController(rootViewController: viewController)

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.backgroundColor = .white
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()

		return true
	}
}
