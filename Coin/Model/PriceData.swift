//
//  PriceData.swift
//  Coin
//
//  Created by Batman 👀 on 16.03.2023.
//

import Foundation

struct PriceData: Codable {
    let time, assetIDBase, assetIDQuote: String
        let rate: Double
    
    var price: String {
        return  String(format: "%.0f", rate)
    }
    
    enum CodingKeys: String, CodingKey {
            case time
            case assetIDBase = "asset_id_base"
            case assetIDQuote = "asset_id_quote"
            case rate
        }
}
