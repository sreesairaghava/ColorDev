//
//  ViewController.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 16/06/22.
//

import UIKit

class ConvertViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var hexTextField: UITextField!
    @IBOutlet weak var rgbTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    //MARK: - Variables
    var hexColor: Box<String?> = Box(nil)
    var rgbColor: Box<String?> = Box(nil)
    var colorViewModel: ColorViewModel = ColorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldDelegates()
        view.backgroundColor = UIColor(hex: "085ea3")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func selectRandomColor() -> UIColor {
        let colors: [UIColor] = [.cyan,.purple,.blue,.brown]
        return colors.randomElement() ?? .yellow
    }
    
    func setupTextFieldDelegates() {
        
//        self.hexTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        [hexTextField, rgbTextField].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0?.autocorrectionType = .no
            $0?.keyboardAppearance = .default
        }
    }
    
    func setDefaultBackgroundColor(_ defaultColor: UIColor = UIColor(hex: "085ea3")) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.view.backgroundColor = defaultColor
        }
    }
    
    //MARK: - Objc Methods
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case hexTextField:
            guard let hexString = textField.text else { return }
            if(!hexString.isEmpty && ColorDevUtils().isValidHexString(hexString)) {
                hexColor.value = hexString
                let rgbValue = getRGBValue(color: UIColor(hex: hexString))
                rgbColor.value = rgbValue
                rgbTextField.text = rgbValue
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                    self.view.backgroundColor = UIColor(hex: hexString)
                }
            }
            else {
              setDefaultBackgroundColor()
            }
        case rgbTextField:
            guard let rgbString = rgbTextField.text else { return }
            if(!rgbString.isEmpty && rgbString.isValidRGB) {
                let components = ColorDevUtils().getColorComponents(string: rgbString)
                let color = ColorDevUtils().getColor(components: components)
                let rgbValue = getRGBValue(color: color)
                rgbColor.value = rgbValue
                let hexString = color.toHexString()
                hexColor.value = hexString
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                    self.view.backgroundColor = color
                    self.hexTextField.text = hexString
                }
            } else {
                setDefaultBackgroundColor()
            }
        default:
            break
        }
       
    }
    
    //MARK: - IBActions
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("Save ButtonPressed: \(hexColor.value ?? "None")")
        guard let hexString = hexColor.value else { return }
        guard let validHex = ColorDevUtils().validateHexString(hexString) else { return }
        guard let validRGB = rgbColor.value else { return }
        let color = Color(hexstring: validHex, rgbString: validRGB)
        if hexString.count >= 6 {
            colorViewModel.storeColor(color: color)
            self.tabBarController?.selectedIndex = 2
        }
        hexColor.value = nil
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        setToDefault()
    }
    
    func getRGBValue(color: UIColor) -> String {
        let components = color.rgb()
        let rgbString = "(\(components?.red ?? 0),\(components?.green ?? 0),\(components?.blue ?? 0))"
        return rgbString
    }
    
    func setToDefault() {
        setDefaultBackgroundColor()
        hexTextField.text = ""
        rgbTextField.text = ""
        hexColor.value = nil
        rgbColor.value = nil
    }
}

extension ConvertViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let hexMaxLength = 7
        let rgbMaxLength = 13
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= (textField == hexTextField ? hexMaxLength : rgbMaxLength)
    }
}
