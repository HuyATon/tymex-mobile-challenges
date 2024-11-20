//
//  FileServiceTest.swift
//  Tymex Currency ConverterTests
//
//  Created by Huy Ton Anh on 20/11/2024.
//

import XCTest
@testable import Tymex_Currency_Converter

final class FileServiceTest: XCTestCase {
    
    let fileService = FileService.shared

    func test_fileExists_fileDoNotExists_false() {
        
        let notExistsFileName = "not_exist_file.json"
        let res = fileService.fileExists(fileName: notExistsFileName)
        
        XCTAssertFalse(res)
    }
    
    func test_fileExists_fileDidExists_true() {
        let existsFileName = "exists_file.json"
        let _ = fileService.createDocumentFilePath(fileName: existsFileName)
        
        let data = Data()
        fileService.writeToFile(fileName: existsFileName, data: data)
        let res = fileService.fileExists(fileName: existsFileName)
        
        XCTAssertTrue(res)
    }
    
    func test_readDataFromFile_fileNotExists_nil() {
        
        let notExistsFileName = "not_exist_file.json"
        let res = fileService.readDataFromFile(fileName: notExistsFileName)
        
        XCTAssertNil(res)
    }
    
    func test_readDataFromFile_fileDidExists_notNil() {
        let existsFileName = "exists_file.json"
        let _ = fileService.createDocumentFilePath(fileName: existsFileName)
        let data = Data()
        fileService.writeToFile(fileName: existsFileName, data: data)
        
        let res = fileService.readDataFromFile(fileName: existsFileName)
        XCTAssertNotNil(res)
    }
    
    func test_writeDataToFile_writeSuccess_true() {
        
        let fileName = "write_dest.json"
        let data = Data()
        
        fileService.writeToFile(fileName: fileName, data: data)
        let res = fileService.readDataFromFile(fileName: fileName)
        
        if let res = res {
            XCTAssert(res == data)
        }
        else {
            XCTFail()
        }
        
    }

}
