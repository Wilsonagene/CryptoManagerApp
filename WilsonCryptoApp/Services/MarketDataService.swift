//
//  MarketDataService.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 6/2/22.
//

import Foundation
import Combine


class  MarketDataService {
    
    @Published var  marketData: MarketDataModel? = nil
    
    var marketDataSubcription: AnyCancellable?
    
    init() {
        getData()
    }
    
    private  func getData() {
        
        guard let url = URL(string:  "https://api.coingecko.com/api/v3/global")
        else { return }
        
        marketDataSubcription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubcription?.cancel()
            })
    }
    
}
