//
//  CoinDetailModel.swift
//  WilsonCryptoApp
//
//  Created by emmanuel agene on 01/07/2022.
//

import Foundation


// url
// https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false


struct CoinDetailModel: Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description, links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
    
    var ReadableDiscription: String! {
        return description?.en?.removingHTMLOccurance
    }
    
}
// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_urL"
    }
    
}
// MARK: - Description
struct Description: Codable {
    let en: String?
}
