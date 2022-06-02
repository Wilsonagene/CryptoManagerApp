//
//  HomeViewModel.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 6/1/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var  statistic: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var SearchText: String = "" 
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        // update all coins
        $SearchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistic = returnedStats
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(Text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !Text.isEmpty else {
            return coins
        }
        // Bitcoin
        // bitcoin
        let lowercasedText = Text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    
    // Update Market Data 
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel]  = []
        
        guard let  data  = marketDataModel else {
            return stats
        }
        
        let  marketCap = StatisticModel(title: "Market Cap", value: data.MarketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        
        let volume = StatisticModel(title: "24H Volume", value: data.Volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
    
}
