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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent) ]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent) ]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
//                XmarkButton()
//                PortfolioView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
