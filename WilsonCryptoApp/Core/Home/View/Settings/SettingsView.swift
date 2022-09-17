//
//  SettingsView.swift
//  WilsonCryptoApp
//
//  Created by emmanuel agene on 17/09/2022.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "http://www.creativeminds.dev")!
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
            List {
                
                FirstSection
                coingeckoSection
                DeveloperSection
                ApplicationSection
                
            }
            .accentColor(Color.blue)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton(presentationMode: _presentationMode)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


extension SettingsView {
    
    private var FirstSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("LoGo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This App want created By WILSON AGENE")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.secondaryText)
            }
            Link("Subcribe on Youtube☺️", destination: youtubeURL)
                .font(.headline)
        } header: {
            Text("Header")
        }
    }
    
    private var coingeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The coin listed in this app comes from a free API from Coingecko!. prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.secondaryText)
            }
            Link("Visit Coingecko🦎", destination: coingeckoURL)
                .font(.headline)
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var DeveloperSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("LoGo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This App want Developed By EMMANUEL WILSON AGENE")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.secondaryText)
            }
            Link("Visit Website", destination: defaultURL)
                .font(.headline)
        } header: {
            Text("Developer")
        }
    }
    
    
    private var ApplicationSection: some View {
        Section {
                Link("Terms of Services", destination: personalURL)
                Link("Privacy & Policy", destination: personalURL)
                Link("Company Website", destination: personalURL)
                Link("Visit Website", destination: personalURL)
                Link("Learn More", destination: personalURL)
        } header: {
            Text("Application")
        }
    }
}
