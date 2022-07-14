//
//  UIView+Extensions.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 16/06/22.
//

import UIKit

extension UIView {
    func roundCorners(cornerRadius: CGFloat, clipToBounds: Bool = true) {
        self.layer.cornerRadius = cornerRadius
        if clipToBounds {
            self.clipsToBounds = true
        }
    }
}
