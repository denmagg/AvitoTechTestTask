//
//  SceneDelegate.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 26.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        router.initialViewController()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
    
}
