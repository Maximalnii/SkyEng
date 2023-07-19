//
//  SceneDelegate.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let viewController = AssemblySearchForm.assemebly()
        let navController = UINavigationController(rootViewController: viewController)
        
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
}
