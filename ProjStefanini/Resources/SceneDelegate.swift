//
//  SceneDelegate.swift
//  ProjStefanini
//
//  Created by Admin on 19/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let rootViewController = SummaryViewController()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
        
    }
    
}

