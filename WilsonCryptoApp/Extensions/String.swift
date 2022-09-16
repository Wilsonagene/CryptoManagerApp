//
//  String.swift
//  WilsonCryptoApp
//
//  Created by emmanuel agene on 16/09/2022.
//

import Foundation

extension String {
    
    var  removingHTMLOccurance: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
