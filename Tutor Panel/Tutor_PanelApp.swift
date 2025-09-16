//
//  Tutor_PanelApp.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/08/2025.
//

import SwiftUI
import Firebase

@main
struct Tutor_PanelApp: App {
    // Register app delegate for Firebase setup
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
