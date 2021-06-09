//
//  String+NSLocalizedString.swift
//  Racing
//
//  Created by Pavel Akulenak on 4.06.21.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
