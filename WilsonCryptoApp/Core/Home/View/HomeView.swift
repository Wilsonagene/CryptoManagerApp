//
//  HomeView.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 5/31/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false //  To animate Right
    @State private var showPortfolioView: Bool = false // new sheet
    @State private var selectedCoin: CoinModel? = nil
    @State private var showdetailView: Bool = false 
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            // content layer
            VStack {
                homeHeader
                HomeStatView(showPortfolio: $showPortfolio)
                SearchBarView(SearchText: $vm.SearchText)
               
                ColumnTitle
                
                if !showPortfolio {
                   allCoinsList
                }
                
                if showPortfolio {
                    portfolioCoinsList
                }
                
                Spacer(minLength: 0)
            }
        }
        .background(
            NavigationLink(isActive: $showdetailView, destination: {
              DetailLodingView(coin: $selectedCoin)
            }, label: { EmptyView() })
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .preferredColorScheme(.dark)
        }
        .environmentObject(dev.homeVM) 
    }
}







extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text( showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
        .transition(.move(edge: .trailing))
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showdetailView.toggle()
    }
    
    private var ColumnTitle: some View {
        HStack {
            HStack(spacing: 4) {
               Text("Coins")
                Image(systemName: "chevron.down")
            .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed ) ? 1.0 : 0.0)
            .rotationEffect(Angle(degrees:  vm.sortOption == .rank ? 0 : 180  ))
          }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed ) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees:  vm.sortOption == .holdings ? 0 : 180  ))
              }
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
                
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed ) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees:  vm.sortOption == .price ? 0 : 180  ))
          }
           .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
           .onTapGesture {
               withAnimation {
                   vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
               }
           }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isloading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    
}
