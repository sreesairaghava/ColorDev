//
//  ColorViewModel.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 17/06/22.
//

import Foundation

struct ColorViewModel {
    let dataManager: DataManager
    init(manager: DataManager = DataManager()) {
        self.dataManager = manager
    }
}

extension ColorViewModel {
    func storeColor(color: Color) {
        dataManager.storeColor(color: color)
    }
    
    func getAllColors() -> [Color] {
        return dataManager.getAllColors()
    }
    func deleteAllColors() {
    }
    
    func deleteColor(color: Color) {
        dataManager.deleteColor(color: color)
    }
}
