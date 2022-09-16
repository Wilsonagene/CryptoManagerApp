//
//  PortfolioView.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 6/3/22.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var seletedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
//      let _ =  Self._printChanges()
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(SearchText: $vm.SearchText)
                    coinLogoList
                    
                    if seletedCoin != nil {
                            portfolioInputSection
                    }
                    
                }
            }
            .navigationBarTitle("Edit Portfolio")
            .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {
//            let _ =  Self._printChanges()
            XmarkButton(presentationMode: _presentationMode)
                    }
        ToolbarItem(placement: .navigationBarTrailing) {
            saveButton
                }
            })
            .onChange(of: vm.SearchText) { Value in
                if Value == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}


extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.SearchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinlogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(seletedCoin?.id == coin.id ? Color.theme.green : Color.blue, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    
    private func updateSelectedCoin(coin: CoinModel) {
        seletedCoin = coin
        
       if  let portfolioCoins = vm.portfolioCoins.first(where: { $0.id == coin.id}),
        let amount = portfolioCoins.currentHoldings {
            quantityText = "\(amount)"
       } else {
           quantityText = ""
       }
    }
    
    private func getCurrentValue()  -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (seletedCoin?.currentPrice ?? 0)
        }
        return 0
    }

    
    private var  portfolioInputSection: some View {
    VStack(spacing: 20) {
        HStack {
            Text("Current price of \(seletedCoin?.symbol.uppercased() ?? "" ):")
            Spacer()
            
            Text(seletedCoin?.currentPrice.asCurrencyWith6Decimals() ??  "")
        }
        
        Divider()
        HStack {
            Text("Amount Holding:")
            Spacer()
            TextField("Ex: 1.4", text: $quantityText)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
        }
        
        Divider()
        HStack {
            Text("Current value:")
            Spacer()
            Text(getCurrentValue().asCurrencyWith2Decimals())
        }
        
    }
    .padding()
    .font(.headline)
    }
  

    
    private  var saveButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .opacity(showCheckmark ?  1.0 : 0.0)
            Button {
                saveButtonpressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (seletedCoin != nil && seletedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func saveButtonpressed() {
        guard
            let coin = seletedCoin,
            let amount = Double(quantityText)
            else { return }
        
        // Save to Portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        //show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // Hide the keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
        
    }
    
    
    
    private func removeSelectedCoin() {
        seletedCoin = nil
        vm.SearchText = ""
    }
    
}


