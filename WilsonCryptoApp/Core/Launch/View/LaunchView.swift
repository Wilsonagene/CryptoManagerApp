//
//  LaunchView.swift
//  WilsonCryptoApp
//
//  Created by Emmanuel Agene on 11/12/2023.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your portfolio......".map({String($0)})
    @State private var showloadingText: Bool = false
   private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showluanchView: Bool
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            ZStack {
                if showloadingText {
                    
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.launch.accent)
                                .offset(y: counter == index ? -5 : 0)
                                
                                
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
//                    Text(loadingText)
                        
                }
                
            }
            .offset(y: 70)
            
        }
        .onAppear(perform: {
            showloadingText.toggle()
        })
        .onReceive(timer, perform: { _ in
            withAnimation(.spring) {
                
                let lastindex = loadingText.count - 1
                    if counter == lastindex {
                        counter = 0
                        loops += 1
                        if loops >= 2 {
                            showluanchView = false
                        }
                    } else {
                        counter += 1
                    }
                
                
            }
        })
    }
}

#Preview {
    LaunchView(showluanchView: .constant(true))
}
