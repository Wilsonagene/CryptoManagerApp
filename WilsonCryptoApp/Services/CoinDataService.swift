//
//  CoinDataService.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 6/1/22.
//

import Foundation
import Combine


//class CoinDataService: ObservableObject {
//    
//    @Published var  allCoins: [CoinModel] = []
//    
//    var coinSubcription: AnyCancellable?
//    
//    var coinListFull = false
//    
//    var currentpage: Int = 0
//    
//    let perpage = 50
//    
//    var loadmore: Bool = false
//    
//    init() {
//        getCoins()
//    }
//    
//    public func getCoins() {
//        
//        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=\(perpage)&page=\(currentpage)&sparkline=true&price_change_percentage=24h")
//        else { return }
//        
//        coinSubcription = NetworkingManager.download(url: url)
//            .decode(type: [CoinModel].self, decoder: JSONDecoder())
//            . receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//                self?.coinSubcription?.cancel()
//                if returnedCoins.count < self!.perpage {
//                    self?.coinListFull = true
//                    self?.loadmore = true
//                }
//                if self?.loadmore == true {
//                    self?.currentpage += 1
//                    self?.allCoins.append(contentsOf: returnedCoins)
//                } else {
//                    print("Can Not Load more🥲")
//                    return
//                    
//                }
//                
//            })
//    }
//    
//}


class CoinDataService: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var isLoading: Bool = false

    var coinSubcription: AnyCancellable?

    var coinListFull = false
    var currentpage = 1
    let perpage = 100
   var canLoadMorePages = true

init() {
    getCoins()
}

public func getCoins() {
    guard !isLoading && canLoadMorePages else {
        return
    }

    isLoading = true
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=\(perpage)&page=\(currentpage)&sparkline=true&price_change_percentage=24h")
    else { return }

    coinSubcription = NetworkingManager.download(url: url)
        .decode(type: [CoinModel].self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] completion in
            NetworkingManager.handleCompletion(completion: completion)
            self?.isLoading = false
        }, receiveValue: { [weak self] returnedCoins in
            self?.allCoins.append(contentsOf: returnedCoins)
            if returnedCoins.count < self!.perpage {
                self?.coinListFull = true
            }
            self?.currentpage += 1
//            print(returnedCoins)
        })
    }
}
