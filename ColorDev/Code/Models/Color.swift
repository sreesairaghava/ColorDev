//
//  Color.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 17/06/22.
//

import Foundation
import RealmSwift

class Color: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var hexString = ""
    @objc dynamic var rgbString = ""
    @objc dynamic var savedDate : Double = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required override init() {
        super.init()
    }
    
    init(hexstring: String, rgbString: String) {
        self.id = UUID().uuidString
        self.hexString = hexstring
        self.rgbString = rgbString
        self.savedDate = Date().timeIntervalSince1970
    }
}
