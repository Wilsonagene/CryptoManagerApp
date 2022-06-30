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
    @Published var isloading: Bool = false
    
    @Published var SearchText: String = "" 
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
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
        
        // update PortfiloCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllcoinToPortfolioCoin)
            .sink { [weak self] (returnedCoin) in
                self?.portfolioCoins = returnedCoin
            }
            .store(in: &cancellables)
        
        // update marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistic = returnedStats
                self?.isloading = false 
            }
            .store(in: &cancellables)
        

    }
    
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isloading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
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
    
    
    private func  mapAllcoinToPortfolioCoin(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    
    // Update Market Data 
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, protfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel]  = []
        
        guard let  data  = marketDataModel else {
            return stats
        }
        
        let  marketCap = StatisticModel(title: "Market Cap", value: data.MarketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        
        let volume = StatisticModel(title: "24H Volume", value: data.Volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let  portfolioValue =
        portfolioCoins
            .map( { $0.currentHoldingsValue } )
            .reduce(0, +)
        
        let previousValue =
              protfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentageChange = coin.priceChangePercentage24H ??  0 / 100
                let previousValue = currentValue / ( 1 + percentageChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
    
}
