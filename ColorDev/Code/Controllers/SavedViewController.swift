//
//  SavedViewController.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 16/06/22.
//

import UIKit

class SavedViewController: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var savedColorTableView: UITableView!
    var colorViewModel: ColorViewModel = ColorViewModel()
    var colors: [Color] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.savedColorTableView.delegate = self
        self.savedColorTableView.dataSource = self
        self.savedColorTableView.register(cell: SavedColorTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchColors()
    }
    
    func fetchColors() {
        colors = colorViewModel.getAllColors()
        DispatchQueue.main.async {
            self.savedColorTableView.reloadData()
        }
    }
    
    func deleteColor(at row: Int) {
        let color = colors[row]
        colors.remove(at: row)
        colorViewModel.deleteColor(color: color)
    }
}

extension SavedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if colors.count == 0 {
            self.savedColorTableView.setEmptyMessage("Ah snap!, please save some colors 🤣")
        } else {
            self.savedColorTableView.restore()
        }
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(SavedColorTableViewCell.self, for: indexPath)
        let data = colors[indexPath.row]
        cell.setup(hex: data.hexString, rgb: data.rgbString)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let convertVC = tabBarController?.viewControllers![0] as! ConvertViewController
        let color = colors[indexPath.row]
        convertVC.view.backgroundColor = UIColor(hex: color.hexString)
        convertVC.hexTextField.text = color.hexString
        convertVC.rgbTextField.text = color.rgbString
        self.tabBarController?.selectedIndex = 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteColor(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
