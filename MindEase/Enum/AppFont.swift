//
//  AppFont.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 21/05/25.
//

import SwiftUI

struct AppFont {
    
    struct Poppins {
        static func regular(_ size: CGFloat) -> Font {
            Font.custom("Poppins-Regular", size: size)
        }
        
        static func extraLight(_ size: CGFloat) -> Font {
            Font.custom("Poppins-ExtraLight", size: size)
        }
        
        static func bold(_ size: CGFloat) -> Font {
            Font.custom("Poppins-Bold", size: size)
        }
    }
    
    struct DMMono {
        static func regular(_ size: CGFloat) -> Font {
            Font.custom("DMMono-Regular", size: size)
        }
        
        static func light(_ size: CGFloat) -> Font {
            Font.custom("DMMono-Light", size: size)
        }
    }
    
}
