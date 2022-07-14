//
//  SavedColorTableViewCell.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 16/06/22.
//

import UIKit

class SavedColorTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var rgbLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: - Variables
    override class func description() -> String {
        return "SavedColorTableViewCell"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        DispatchQueue.main.async {
            self.containerView.backgroundColor = UIColor(hex: "ffcfac")
            self.containerView.roundCorners(cornerRadius: 8)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(hex:String,rgb:String) {
        hexLabel.text = hex
        rgbLabel.text = "rgb"+rgb
        DispatchQueue.main.async {
            if !hex.isEmpty {
                self.containerView.backgroundColor = UIColor(hex: hex)
            }
        }
    }
    
}

extension SavedColorTableViewCell: ResuableCellProtocol, UINibInstantiable {}
