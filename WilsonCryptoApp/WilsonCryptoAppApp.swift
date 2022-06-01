//
//  WilsonCryptoAppApp.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 5/31/22.
//

import SwiftUI

@main
struct WilsonCryptoAppApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
