//
//  FetchServiceTest.swift
//  Tymex Currency ConverterTests
//
//  Created by Huy Ton Anh on 20/11/2024.
//

import XCTest
@testable import Tymex_Currency_Converter

final class FetchServiceTest: XCTestCase {

    let fetcher = FetchService.shared
    typealias APIError = FetchService.APIError
    
    func test_fetchData_noAccessKeyProvided_throws() async {
        
        let wrongUrlString = "https://api.exchangeratesapi.io/v1/latest?access_key="
        
        do {
            let _ = try await fetcher.fetchData(urlString: wrongUrlString)
        }
        catch {
            XCTAssertTrue(error.localizedDescription == APIError.badResponse.localizedDescription)
        }
    }
    
    func test_fetchData_accessKeyProvidedAndValid_true() async {
        let data = try? await fetcher.fetchData(urlString: fetcher.apiUrlString)
        
        XCTAssertNotNil(data)
    }

}
