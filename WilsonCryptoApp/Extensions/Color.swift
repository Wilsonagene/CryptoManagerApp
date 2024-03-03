//
//  Color.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 5/31/22.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme() 
    static let launch = LaunchTheme()
    
}



struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    
}


struct LaunchTheme {
    let accent = Color("LaunchAccentColors")
    let background = Color("LaunchBackgroundColor")
}
