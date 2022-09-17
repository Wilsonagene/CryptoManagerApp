//
//  DetailsView.swift
//  WilsonCryptoApp
//
//  Created by emmanuel agene on 01/07/2022.
//

import SwiftUI

struct DetailLodingView: View {
    @Binding var  coin: CoinModel?
    var body: some View {
        ZStack {
            if let coin = coin {
               DetailsView(coin: coin)
            }
        }
    }
}

struct DetailsView: View {
    
    @StateObject var vm: DetailViewModel
    @State var showFullDescription: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let Spacing: CGFloat = 30
    
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("initalizing Detail view for \(coin.name)")
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    Descriptionsection
                    overviewGrid
                   additionalTitle
                    Divider()
                    additionalGrid
                    WebsiteSection
                   
                }.padding()
            }
            
            
            
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NaivigationBarTrailingItems
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView(coin: dev.coin)
        }
        
    }
}


extension DetailsView {
    
    
    private var NaivigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
            .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
            
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var Descriptionsection: some View {
        ZStack {
           
            if let  coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                withAnimation(.easeIn) {
                    VStack(alignment: .leading) {
                        Text(coinDescription)
                            .lineLimit( showFullDescription ? nil : 3)
                            .font(.callout)
                            .foregroundColor(Color.theme.secondaryText)
                        
                        Button {
                            withAnimation(.easeInOut) {
                                showFullDescription.toggle()
                            }
                        } label: {
                            Text( showFullDescription ?  " Read Less" :"Read More..")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color.blue)
                        }
                        .padding(.vertical, 0.1)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
}
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: Spacing,
            pinnedViews: []) {
                ForEach(vm.overviewStatistic) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: Spacing,
            pinnedViews: []) {
                ForEach(vm.additionalStatistic) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var WebsiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let WebsiteLink = vm.websiteURL,
                let url = URL(string: WebsiteLink) {
                Link("Website", destination: url)
            }
            
            if let RedditString = vm.redditURL,
               let url = URL(string: RedditString) {
                Link("Reddit", destination: url)
            }
        }
        .accentColor(Color.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
