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
        let text = "Nickname: \(name), Level: \(level), Score: \(score)"
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let resultFilePath = directory.appendingPathComponent(file)
            do {
                try text.write(to: resultFilePath, atomically: false, encoding: .utf8)
            } catch {
                print("Can't save resoults")
            }
        }
    }
}
