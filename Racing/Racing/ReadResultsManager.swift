//
//  ReadResultsManager.swift
//  Racing
//
//  Created by Pavel Akulenak on 10.05.21.
//

import Foundation

enum ReadResultsManager {
    static func readFromResults() {
        guard let resultsFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        guard let resultsFilesNameArray = try? FileManager.default.contentsOfDirectory(at: resultsFolderPath, includingPropertiesForKeys: nil, options: []) else {
            return
        }
        for item in resultsFilesNameArray {
            guard let data = try? Data(contentsOf: item) else {
                return
            }
            guard let results = try? JSONDecoder().decode(Results.self, from: data) else {
                return
            }
            print(results)
        }
    }
}
