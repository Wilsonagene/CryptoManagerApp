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
    
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("initalizing Detail view for \(coin.name)")
    }
    
    var body: some View {
                Text("hello👋")
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(coin: dev.coin)
    }
}
