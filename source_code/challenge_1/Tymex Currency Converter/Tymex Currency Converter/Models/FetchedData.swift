//
//  FetchData.swift
//  Tymex Currency Converter
//
//  Created by Huy Ton Anh on 20/11/2024.
//

import Foundation

struct FetchedData: Codable {
    
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}


extension FetchedData {
    
    static let mock: FetchedData = FetchService.shared.fetch()!
}
