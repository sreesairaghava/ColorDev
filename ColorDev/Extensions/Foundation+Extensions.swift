//
//  Foundation+Extensions.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 17/06/22.
//
import Foundation

extension String {
    var isHexNumber: Bool {
        filter(\.isHexDigit).count == count
    }
}

extension StringProtocol {
    var isValidRGB: Bool { range(of: #"^\((((([1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])),){2}(([1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5]))(;|; )?){1,}\)$"#,
                                 options: .regularExpression) != nil }
}


// \b(1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])\b


