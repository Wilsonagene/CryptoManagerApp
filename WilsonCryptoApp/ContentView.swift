//
//  ContentView.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 5/31/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Secondary Color")
                    .foregroundColor(Color.theme.secondaryText)
                
                Text("Red")
                    .foregroundColor(Color.theme.red)
                
                Text("green")
                    .foregroundColor(Color.theme.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
