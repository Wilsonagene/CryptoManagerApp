//
//  Date.swift
//  WilsonCryptoApp
//
//  Created by emmanuel agene on 16/09/2022.
//

import Foundation

extension Date {
    
    init(coinGeckoString: String!) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFomatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateSting() -> String {
        return shortFomatter.string(from: self)
    }
}
