//
//  Protocols.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 16/06/22.
//

import UIKit

protocol ResuableCellProtocol: AnyObject {}
protocol UINibInstantiable {}

typealias Reusable = ResuableCellProtocol & UINibInstantiable

extension UINibInstantiable {
    static var nibName: String {
        "\(Self.self)"
    }
}

extension UINib {
    convenience init(for cell: UINibInstantiable.Type) {
        self.init(nibName: "\(cell.nibName)", bundle: Bundle.main)
    }
}

extension ResuableCellProtocol {
    static var reuseIdentifier: String {
        "\(Self.self)"
    }
}
