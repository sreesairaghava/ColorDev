//
//  UITableView+Extensions.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 16/06/22.
//

import UIKit

extension UITableView {
    func register(cell: Reusable.Type) {
        self.register(UINib(for: cell), forCellReuseIdentifier: cell.reuseIdentifier)
    }
    func dequeReusableCell<T>(_ cell: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        dequeueReusableCell(withIdentifier: cell.reuseIdentifier) as! T
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .label
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Avenir", size: 20)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .singleLine
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

