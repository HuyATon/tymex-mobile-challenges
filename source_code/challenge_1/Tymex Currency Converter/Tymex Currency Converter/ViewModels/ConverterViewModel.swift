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
    @Published var networkStatus: NetworkingStatus = .notStarted
    @Published var networkMessage: String
    @Published var status: Status
    @Published var statusMessage: String
    @Published var fetched: Bool
    
    let fetcher: FetchService
    let fileService: FileService
    let fileName: String
    
    init() {
        fetchedData = nil
        networkStatus = .notStarted
        networkMessage = ""
        status = .notStarted
        statusMessage = ""
        fetched = false
        
        fetcher = FetchService.shared
        fileService = FileService.shared
        fileName = "fetched_data.json"
    }
    // Computed Properties
    var updatedTime: Date? {
        if let timestamp = fetchedData?.timestamp {
            
            return Date(timeIntervalSince1970: TimeInterval(timestamp))
        }
        return nil
    }
    
    // Methods
    func fetchNewestData() async {
        do {
            networkStatus = .loading
            fetchedData = try await fetcher.fetchData()
            networkStatus = .successful
            networkMessage = "Successfully update newest data"
            fetched = true
            
            saveFetchedData(fetchedData: fetchedData!)
        }
        catch {
            networkStatus = .failed
            networkMessage = error.localizedDescription
            
            readMostRecentData()
        }
    }
    
    func saveFetchedData(fetchedData: FetchedData) {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(fetchedData)
            fileService.writeToFile(fileName: self.fileName, data: data)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func readMostRecentData() {
        let decoder = JSONDecoder()
        if let data = fileService.readDataFromFile(fileName: self.fileName),
           let decodedData = try? decoder.decode(FetchedData.self, from: data) {
            fetchedData = decodedData
            status = .successful
            statusMessage = "Read from most recentl records."
            fetched = true
        }
        else {
            status = .failed
            statusMessage = "Can not read data from local file"
        }
    }
    
    
    func getCurrencyValue(_ currency: String) -> Double? {
        
        if let value = fetchedData?.rates[currency] {
            return value
        }
        
        return nil
    }
    
    func getSortedAvailableCurrency() -> [String] {
        
        if let currencies = fetchedData?.rates.keys {
            
            return currencies.sorted()
        }
        return []
    }
    
    
    func convert(amount: String, source: String, dest: String) -> Double {
        guard let validAmount = Double(amount) else {
            status = .failed
            statusMessage = "Input format is invalid!"
            return 0
        }
        
        guard let sourceValue = getCurrencyValue(source),
              let destValue = getCurrencyValue(dest) else {
            status = .failed
            statusMessage = "Currency in from/to is invalid"
            return 0
        }
        
        let sourceCurrency = Currency(name: source, value: sourceValue)
        let destCurrency = Currency(name: dest, value: destValue)
        
        return sourceCurrency.convertTo(destCurrency, withAmount: validAmount)
    }
    
}
