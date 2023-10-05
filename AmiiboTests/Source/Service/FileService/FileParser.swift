//
//  FileManager.swift
//  AmiiboTests
//
//  Created by Rodrigo Valladares on 12/6/23.
//

import Foundation

enum FileParser {
    static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
