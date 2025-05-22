//
//  MindEaseApp.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

@main
struct MindEaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("signIn") var isSignIn = false
    
    var body: some Scene {
        WindowGroup {
            if !isSignIn {
                LoginView()
            } else {
                NavigationStack {
                    DiscoverView()
                }
            }
        }
    }
}
