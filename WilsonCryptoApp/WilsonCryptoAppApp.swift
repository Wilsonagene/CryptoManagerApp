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
    @State private var showluanchview: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent) ]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent) ]
    }
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm)
                
                ZStack {
                    if showluanchview {
                        LaunchView(showluanchView: $showluanchview)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
                
               
            }
            
           
        }
    }
}
