//
//  AuthViewModel.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import Foundation
import GoogleSignIn
import Firebase
import FirebaseAuth
import UIKit

class AuthViewModel: ObservableObject {
    
    func googleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let presentingVC = getPresentingViewController() else {
//            print("Cannot find vc")
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
//            if let error = error {
//                print("Google Sign-In error: \(error.localizedDescription)")
//                return
//            }

            guard
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
//                print("Failed to get token")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in
                guard let user = result?.user else { return }
//                if let error = error {
//                    print("Firebase Sign-In error: \(error.localizedDescription)")
//                    return
//                }

                UserDefaults.standard.set(true, forKey: "signIn")
                UserDefaults.standard.set(user.email, forKey: "userEmail")
                UserDefaults.standard.set(user.displayName, forKey: "userName")
                if let photoURL = user.photoURL?.absoluteString {
                    UserDefaults.standard.set(photoURL, forKey: "userProfileImage")
                }
//                print("Sign In Success")
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            UserDefaults.standard.set(false, forKey: "signIn")
        } catch {
            print("Error during sign out: \(error.localizedDescription)")
        }
    }

    private func getPresentingViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first,
              let root = window.rootViewController else {
            return nil
        }

        var topController = root
        while let presented = topController.presentedViewController {
            topController = presented
        }

        return topController
    }
}
