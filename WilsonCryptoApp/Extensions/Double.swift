//
//  Double.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 6/1/22.
//

import Foundation


extension Double {
    
    
    /// Convert a Double into a Currency With 2 decimal places
    ///  ```
    /// Convert 1234.56 to $1,234.56
    ///  ```
    
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale(identifier: "en_US") /// to make my currency dollar $ ( to assing country)
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    /// Convert a Double into a Currency as a String with 2 decimal places
    ///  ```
    /// Convert 1234.56 to "$1,234.56"
    ///  ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    
    
    /// Convert a Double into a Currency With 2-6 decimal places
    ///  ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    ///  ```
    
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale(identifier: "en_US") /// to make my currency dollar $ ( to assing country)
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    /// Convert a Double into a Currency as a String with 2-6 decimal places
    ///  ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    ///  ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Convert a Double into String representation
    ///  ```
    /// Convert 1.2345 to "1.23"
    ///  ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Convert a Double into String representation with percent symbol
    ///  ```
    /// Convert 1.2345 to "1.23%"
    ///  ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    
    /// Convert a Double into a String with K,M,Bn,Tr abbrivations.
    /// ```
    ///
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 122345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    ///
    /// ```
    func formattedWithAbbrivations() -> String  {
         let num = abs(Double(self))
        let sign = (self < 0) ? "" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringformatted = formatted.asNumberString()
            return "\(sign)\(stringformatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringformatted = formatted.asNumberString()
            return "\(sign)\(stringformatted)Br"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringformatted = formatted.asNumberString()
            return "\(sign)\(stringformatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringformatted = formatted.asNumberString()
            return "\(sign)\(stringformatted)K"
        case 0...:
            return self.asNumberString()
            
        default:
            return "\(sign)\(self)"
        }
    }
}
