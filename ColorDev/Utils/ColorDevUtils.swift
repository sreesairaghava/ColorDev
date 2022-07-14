//
//  ColorDevUtils.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 17/06/22.
//

import UIKit

struct ColorDevUtils {
    func isValidHexString(_ hexString:String) -> Bool {
        let hexStringRegex = "^(?:[0-9a-fA-F]{3}){1,2}$"
        let hexPredicate = NSPredicate(format: "SELF MATCHES %@", hexStringRegex)
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        return hexPredicate.evaluate(with: hexSanitized)
    }
    
    func validateHexString(_ hexString: String) -> String? {
        if !hexString.isEmpty {
            if isValidHexString(hexString) {
                return hexString
            }
        }
        return nil
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func getColorComponents(string: String) -> [String]{
        let regex = "(1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])"
        return matches(for: regex, in: string)
    }
    
    func getColor(components: [String]) -> UIColor {
        let redComponent = Int(components[0]) ?? 0
        let greenComponent = Int(components[1]) ?? 0
        let blueComponent = Int(components[2]) ?? 0
        return UIColor(red: redComponent, green: greenComponent, blue: blueComponent)
    }
}
