//
//  ExchangeRatesViewModel.swift
//  Tymex Currency Converter
//
//  Created by HUY TON on 16/11/24.
//

import Foundation


class ExchangeRatesViewModel: ObservableObject {
    
    
    @Published var currencies: [Currency]
    @Published var showLowestRate = true
    @Published var baseCurrency: String
    
    
    init(fetchedData: FetchedData?) {
        if let fetchedData = fetchedData {
            currencies = fetchedData.rates.map { Currency(name: $0.key, value: $0.value) }.sorted{ $0.value > $1.value }
        }
        else {
            currencies = []
        }
        showLowestRate = true
        baseCurrency = FetchService.shared.baseCurrency
    }
    
    var sortedCurrencies: [Currency] {
        self.currencies.sorted { showLowestRate ? $0.value < $1.value : $0.value > $1.value }
    }
}
