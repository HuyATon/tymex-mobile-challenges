//
//  FetchService.swift
//  Tymex Currency Converter
//
//  Created by HUY TON on 16/11/24.
//

import Foundation


class FetchService {
    
    enum APIError: Error, LocalizedError {
        
        case badUrl
        case badResponse
        case badData
        
        var errorDescription: String? {
            switch self {
            case .badUrl:
                return NSLocalizedString("The endpoint is unreachable", comment: "")
            case .badResponse:
                return NSLocalizedString("Failed to receive valid response", comment: "")
            case .badData:
                return NSLocalizedString("Cannot decode data", comment: "")
            }
        }
        
    }
    
    
    static let shared = FetchService()
    
    let baseUrl: String
    let apiKey: String
    let baseCurrency: String
    
    private init() {
        
        baseUrl = "https://api.exchangeratesapi.io/v1/latest"
        apiKey = "0b54dbd730ea7ea1e70690296a25f8e6"
        baseCurrency = "EUR"
        
        
    }
    
    var apiUrlString: String {
        
        return baseUrl + "?access_key=\(apiKey)&base=\(baseCurrency)"
    }
    
    func fetch() -> FetchedData? {
        
        let decoder = JSONDecoder()
        
        
        if let url = Bundle.main.url(forResource: "data", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            
            do {
                let decodedData = try decoder.decode(FetchedData.self, from: data)
                return decodedData
            }
            catch {
                return nil
            }
        }
        
        return nil
    }
    
    func fetchData()  async throws  -> FetchedData?{
        
        guard let url = URL(string: self.apiUrlString) else {
            throw APIError.badUrl
        }
        
        do {
            let (data, res) = try await URLSession.shared.data(from: url)
            
            guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
                throw APIError.badResponse
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(FetchedData.self, from: data)
            return decodedData
        }
        catch {
            throw error
        }
        
    }
    
    
}
