//
//  ConvertViewModel.swift
//  Tymex Currency Converter
//
//  Created by HUY TON on 15/11/24.
//

import Foundation

@MainActor
class ConverterViewModel: ObservableObject {
    
    
    @Published var fetchedData: FetchedData? = nil
    @Published var status: NetworkingStatus = .notStarted
    @Published var message = ""
    @Published var fetched = false
    
    let fetcher = FetchService.shared
    
    
    var updatedTime: Date? {
        if let timestamp = fetchedData?.timestamp {
            
            return Date(timeIntervalSince1970: TimeInterval(timestamp))
        }
        return nil
    }
    
    func fetchNewestData() async {
        do {
            status = .loading
            fetchedData = try await fetcher.fetchData()
            status = .successful
            message = "Successfully update newest data"
            fetched = true
        }
        catch {
            status = .failed
            message = error.localizedDescription
        }
    }
    
    
    func getCurrencyValue(_ currency: String) -> Double {
        
        if let value = fetchedData?.rates[currency] {
            return value
        }
        
        return 0
        
    }
    
    func getSortedAvailableCurrency() -> [String] {
        
        if let currencies = fetchedData?.rates.keys {
            
            return currencies.sorted()
        }
        return []
    }
    
    
    func convert(amount: String, source: String, dest: String) -> Double {
        
        // MARK: Formula: amount / source * dest
        // x USD -> VND: x / (EUR / USD) * (EUR / VND) = x USD / VND
        
        
        if let value = Double(amount),
           let data = self.fetchedData{
            
            let source_base = getCurrencyValue(source)
            let dest_base = getCurrencyValue(dest)
            
            return value / source_base * dest_base
        }
        else {
            return 0
        }
        
    }
    
}
