//
//  HapticManager.swift
//  WilsonCryptoApp
//
//  Created by emmanuel agene on 30/06/2022.
//

import Foundation
import SwiftUI
 
class HapticManager {
    
    
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType ) {
        generator.notificationOccurred(type)
    }
}
