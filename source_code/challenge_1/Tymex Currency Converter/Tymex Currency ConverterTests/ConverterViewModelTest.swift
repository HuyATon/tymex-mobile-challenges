//
//  ConverterViewModelTest.swift
//  Tymex Currency ConverterTests
//
//  Created by Huy Ton Anh on 20/11/2024.
//

import XCTest
@testable import Tymex_Currency_Converter
@MainActor
final class ConverterViewModelTest: XCTestCase {
    
    let vm = ConverterViewModel()
    
    func test_fetchNewestData_invalidUrlString_failed() async {
        
        let invalidUrl = "abc"
        await vm.fetchNewestData(urlString: invalidUrl)
        
        XCTAssert(vm.networkStatus == .failed)
    }
    
    func test_fetchNewestData_validUrlString_success() async {
        
        let validUrl = vm.fetcher.apiUrlString
        await vm.fetchNewestData(urlString: validUrl)
        
        XCTAssert(vm.networkStatus == .successful)
    }
    
    func test_saveFetchedData_validFetchedData_success() async {
        
        let savedFileName = "repo.json"
        let saveData = FetchedData.mock
        vm.saveFetchedData(fetchedData: saveData, toFile: savedFileName)
        
        let readData = vm.readMostRecentData(fromFile: savedFileName)
        
        XCTAssertNotNil(readData)
        XCTAssert(saveData.rates.count == readData!.rates.count)
    }
    
    func test_readMostRecentData_didNotSave_failed() {
        let noFoundFileName = "empty"
        let _ = vm.readMostRecentData(fromFile: noFoundFileName)
        XCTAssert(vm.status == .failed)
    }
    
    func test_readMostRecenData_didSave_success() {
        
        let saveFile = "save_file.json"
        let data = FetchedData.mock
        vm.saveFetchedData(fetchedData: data, toFile: saveFile)
        let readData = vm.readMostRecentData(fromFile: saveFile)
        
        XCTAssertNotNil(readData)
        XCTAssert(data.rates.count == readData!.rates.count)
    }
    
    func test_convert_invalidInputFormat_failed() {
        
        vm.fetchedData = FetchedData.mock
        let wrongInput = "abc,123"
        
        let _ = vm.convert(amount: wrongInput, source: "USD", dest: "VND")
        
        XCTAssert(vm.status == .failed)
    }
}
