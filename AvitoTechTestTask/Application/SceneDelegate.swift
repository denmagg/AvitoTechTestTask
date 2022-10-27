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
         
         //создали наш window
         window = UIWindow(frame: windowScene.coordinateSpace.bounds)
         //передали ему сцену
         window?.windowScene = windowScene
         
         let navigationController = UINavigationController()
         let assemblyBuilder = AssemblyBuilder()
         let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
         
         router.initialViewController()
         
         //сказали что у window будет rotVC это наш navBar у которого тоже свой root есть
         window?.rootViewController = navigationController
         //виндов покажи
         window?.makeKeyAndVisible()

    }

}
