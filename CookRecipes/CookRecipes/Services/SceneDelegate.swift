//
//  SceneDelegate.swift
//  CookRecipes
//
//  Created by Влад on 08.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
             guard let windowScene = (scene as? UIWindowScene) else { return }
                 window = UIWindow(frame: windowScene.coordinateSpace.bounds)
                 window?.windowScene = windowScene
       // self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = TabBarAssembly().build()
        self.window?.makeKeyAndVisible()

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataService.shared.saveContext()
       // (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
