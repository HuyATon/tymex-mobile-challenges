//
//  Tymex_Currency_ConverterTests.swift
//  Tymex Currency ConverterTests
//
//  Created by Huy Ton Anh on 20/11/2024.
//

import XCTest
@testable import Tymex_Currency_Converter

final class CurrencyTest: XCTestCase {
    // MARK: template: test_whatIsTested_whatIsTheCircumstance_whatIsExpect

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func test_convertCurrencyToAnother_validSourceAndDest_success() {
        // convert 5 USD -> ? VND
        let amount: Double = 5
        let sourceCurrency = Currency(name: "USD", value: 1.06)
        let destCurrency = Currency(name: "VND", value: 26800.0)
        
        let convertedValue = sourceCurrency.convertTo(destCurrency, withAmount: amount)
        let stringRes = String(format: "%.1f", convertedValue)
        
        XCTAssertEqual(stringRes, "126415.1")
        
    }


}
