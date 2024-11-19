//
//  ExchangeRatesViewModel.swift
//  Tymex Currency Converter
//
//  Created by HUY TON on 16/11/24.
//

import Foundation


class ExchangeRatesViewModel: ObservableObject {
    
    
    @Published var currencies: [Currency] = []
    @Published var showLowestRate = true
    
    
    var baseCurrency: String {
        FetchService.shared.baseCurrency
    }
    
    init(fetchedData: FetchedData) {
        let base = fetchedData.base
        self.currencies = fetchedData.rates.map { Currency(name: $0.key, base: base, value: $0.value) }.sorted{ $0.value > $1.value }
    }
    
    var sortedCurrencies: [Currency] {
        self.currencies.sorted { showLowestRate ? $0.value < $1.value : $0.value > $1.value }
    }
    
    
}
