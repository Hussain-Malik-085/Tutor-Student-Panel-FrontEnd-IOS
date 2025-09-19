//
//  Application.swift
//  Tutor Panel
//
//  Created by MetaDots on 16/09/2025.
//


import UIKit
import Firebase
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Configure Firebase
        FirebaseApp.configure()
        
        // 🔎 Debugging: Check Firebase Client ID
        if let clientID = FirebaseApp.app()?.options.clientID {
            print("✅ Firebase Client ID loaded: \(clientID)")
        } else {
            print("❌ No Firebase Client ID found")
        }
        
        
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
