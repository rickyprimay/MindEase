//
//  Extensions+View.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
    func setNavigationBarTitleFont(size: CGFloat = 14, weight: UIFont.Weight = .regular) -> some View {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: size, weight: weight)
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        return self
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
#endif
