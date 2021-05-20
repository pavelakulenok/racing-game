//
//  ReadResultsManager.swift
//  Racing
//
//  Created by Pavel Akulenak on 10.05.21.
//

import Foundation

enum ReadResultsManager {
    static func readFromResults() -> [Results] {
        var array = [Results]()
        guard let resultsFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        guard let resultsFilesNameArray = try? FileManager.default.contentsOfDirectory(at: resultsFolderPath, includingPropertiesForKeys: nil, options: []) else {
            return []
        }
        for item in resultsFilesNameArray {
            do {
                let data = try Data(contentsOf: item)
                let results = try JSONDecoder().decode(Results.self, from: data)
                array.append(results)
            } catch {
                print("can't decode data from \(resultsFolderPath)")
            }
        }
        return array
    }
}
