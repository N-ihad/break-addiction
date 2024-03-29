//
//  SceneDelegate.swift
//  Break Addiction
//
//  Created by Nihad on 4/16/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let loginController: SettingAddictionVC = storyboard.instantiateViewController(withIdentifier: "settingAddictionID")  as? SettingAddictionVC {
//            print("entered here")
//            loginController.modalPresentationStyle = .fullScreen
//            self.window?.rootViewController?.present(loginController, animated: true, completion: nil)
//        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        CoreDataManager.saveContext()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        CoreDataManager.saveContext()
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {

    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
}

