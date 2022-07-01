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
    
    let  coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("initalizing Detail view for \(coin.name)")
    }
    
    var body: some View {
                Text(coin.name)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(coin: dev.coin)
    }
}
