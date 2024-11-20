//
//  Currency.swift
//  Tymex Currency Converter
//
//  Created by HUY TON on 15/11/24.
//

import Foundation


struct Currency {
    
    var name: String
    var value: Double
    
    func convertTo(_ otherCurrency: Currency, withAmount amount: Double) -> Double {
        return amount / self.value * otherCurrency.value
    }
   
}
