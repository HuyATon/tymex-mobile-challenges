import Foundation

enum NetworkingStatus {
    
    case notStarted, loading, successful, failed
}

struct FetchedData: Decodable {
    
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}



