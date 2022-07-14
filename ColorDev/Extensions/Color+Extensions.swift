//
//  Color+Extensions.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 16/06/22.
//

import UIKit

extension UIColor {
    /// For converting Hex-based colors
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*256) << 16 | (Int)(g*255) << 8 | (Int) (b*255) << 0
        
        return NSString(format:"#%06x", rgb) as String
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
            assert(red >= 0 && red <= 255, "Invalid red component")
            assert(green >= 0 && green <= 255, "Invalid green component")
            assert(blue >= 0 && blue <= 255, "Invalid blue component")

            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        }
    
    func rgb() -> (red:Int, green:Int, blue:Int)? {
           var fRed : CGFloat = 0
           var fGreen : CGFloat = 0
           var fBlue : CGFloat = 0
           var fAlpha: CGFloat = 0
           if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
               let iRed = Int(fRed * 255.0)
               let iGreen = Int(fGreen * 255.0)
               let iBlue = Int(fBlue * 255.0)

               return (red:iRed, green:iGreen, blue:iBlue)
           } else {
               // Could not extract RGBA components:
               return nil
           }
       }
}
