//
//  DetailViewModel.swift
//  WilsonCryptoApp
//
//  Created by emmanuel agene on 01/07/2022.
//

import Foundation
import Combine

class  DetailViewModel: ObservableObject {
    
    @Published var overviewStatistic: [StatisticModel] = []
    @Published var additionalStatistic: [StatisticModel] = []
    
    @Published var  coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin 
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map({ (coinDetailModel, coinModel) -> (overview:[StatisticModel], additional: [StatisticModel]) in
                
                
                // overview
                let price = coinModel.currentPrice.asCurrencyWith6Decimals()
                let pricePersentChange = coinModel.priceChangePercentage24H
                let priceStat = StatisticModel(title: "Current price", value: price, percentageChange: pricePersentChange)
                
                let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbrivations() ?? "")
                let marketCapPersentChange = coinModel.marketCapChangePercentage24H
                let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPersentChange)
                
                let rank = "\(coinModel.rank)"
                 let rankStat = StatisticModel(title: "Rank", value: rank)
                
                let volume = "$" + (coinModel.totalVolume?.formattedWithAbbrivations() ?? "" )
                let volumeStat = StatisticModel(title: "Volume", value: volume)
                
                let  overviewArray: [StatisticModel] = [
                    priceStat, marketCapStat, rankStat, volumeStat
                ]
                
                
                //additional
                let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
                let highStat = StatisticModel(title: "24h High", value: high)
                
                let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
                let lowStat = StatisticModel(title: "24h Low", value: low)
                
                let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
                let pricePersentChange2 = coinModel.priceChangePercentage24H
                let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePersentChange2)
                
                let marketCapChange = "$" + (coinModel.marketCapChangePercentage24H?.formattedWithAbbrivations() ?? "" )
                let marketCapPersentChange2 = coinModel.marketCapChangePercentage24H
                let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPersentChange2)
                
                let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
                let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
                let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
                
                let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StatisticModel(title: "Hashing Algorithm ", value: hashing)
                
                let additionalArray: [StatisticModel] = [ highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat]
                
                return (overviewArray, additionalArray)
            })
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistic = returnedArrays.overview
                self?.additionalStatistic = returnedArrays.additional
            }
            .store(in: &cancellables)
        
    }
    
    
}
