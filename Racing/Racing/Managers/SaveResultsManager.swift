//
//  SaveResoultsManager.swift
//  Racing
//
//  Created by Pavel Akulenak on 3.05.21.
//

import Foundation

enum SaveResultsManager {
    static func saveResults(level: Int, score: Int) {
        let file = "\(Date())"
        guard let name = UserDefaults.standard.string(forKey: "nickname") else {
            return
        }
        let resultsOfGame = Results(name: name, score: score, level: level)
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let resultFilePath = directory.appendingPathComponent("\(file).json")
            do {
                let data = try JSONEncoder().encode(resultsOfGame)
                try data.write(to: resultFilePath)
            } catch {
                print("Error! Can't write resultsOfGame to \(resultFilePath)")
            }
        }
    }
}
