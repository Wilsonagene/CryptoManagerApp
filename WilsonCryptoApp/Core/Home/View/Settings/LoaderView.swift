//
//  LoaderView.swift
//  WilsonCryptoApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import SwiftUI

struct LoaderView: View {
    
    @State private var isAnimated: Bool = false
    @State private var scale = 0.5
    
    var body: some View {
        HStack {
            
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(isAnimated ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever())
                
            
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(isAnimated ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
            
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(isAnimated ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
            
        }
        .onAppear {
            self.isAnimated = true
        }
    }
}

#Preview {
    LoaderView()
}
