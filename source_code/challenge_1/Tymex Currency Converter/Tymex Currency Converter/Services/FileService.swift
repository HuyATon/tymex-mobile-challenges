//
//  FileService.swift
//  Tymex Currency Converter
//
//  Created by HUY TON on 16/11/24.
//

import Foundation


class FileService {
    
    private init() { }
    static let shared = FileService()
    
    func getDocumentDirectory() -> URL {
     
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dirPath = paths[0]
        return dirPath
    }
    
    func createDocumentFilePath(fileName: String) -> URL {
        
        let dirPath = getDocumentDirectory()
        let filePath = dirPath.appendingPathComponent(fileName)
        return filePath
    }
    
    func fileExists(fileName: String) -> Bool {
        let filePath = createDocumentFilePath(fileName: fileName)
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath.path) {
            return true
        }
        return false
    }
    
    func readDataFromFile(fileName: String) -> Data? {
        if fileExists(fileName: fileName) {
            let filePath = createDocumentFilePath(fileName: fileName)
            
            return try? Data(contentsOf: filePath)
        }
        return nil
    }
    
    func writeToFile(fileName: String, data: Data)  {
        
        let writePath = createDocumentFilePath(fileName: fileName)
        do {
            try data.write(to: writePath)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
