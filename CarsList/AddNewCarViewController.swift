//
//  AddNewCarViewController.swift
//  CarsList
//
//  Created by Максим Солнцев on 9/16/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewCarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var manufacturerTextField: UITextField!
    @IBOutlet weak var modelNameTextField: UITextField!
    @IBOutlet weak var yearOfProductionTextField: UITextField!
    @IBOutlet weak var bodyStyleTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    let dbmanager = DBManager()
    var newCar = Car()
    let picker = UIPickerView()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        modelNameTextField.delegate = self  
        manufacturerTextField.delegate = self
        yearOfProductionTextField.delegate = self
        bodyStyleTextField.delegate = self
        yearOfProductionTextField.keyboardType = .numberPad
        bodyStyleTextField.inputView = picker
        errorLabel.isHidden = true
        manufacturerTextField.text = newCar.nameManufacturer
        modelNameTextField.text = newCar.nameModel
        yearOfProductionTextField.text = newCar.yearOfProduction
        bodyStyleTextField.text = newCar.bodyStyleRawValue
    }
    
    func addNewCar() {
        
        try! realm.write {
            newCar.nameModel = modelNameTextField.text!
            newCar.nameManufacturer = manufacturerTextField.text!
            newCar.yearOfProduction = yearOfProductionTextField.text!
            switch bodyStyleTextField.text {
            case "Coupe":
                newCar.bodyStyle = .Coupe
            case "Hatchback":
                newCar.bodyStyle = .Hatchback
            case "Sedan":
                newCar.bodyStyle = .Sedan
            default:
                bodyStyleTextField.text = "Unknowed body style"
            }
        }
        dbmanager.saveCar(car: newCar)
    }
    
    
    func checkValid() -> String? {
        if manufacturerTextField.text == "" ||
            modelNameTextField.text == "" ||
            yearOfProductionTextField.text == "" ||
            bodyStyleTextField.text == "" ||
            manufacturerTextField.text == nil ||
            modelNameTextField.text == nil ||
            yearOfProductionTextField.text == nil ||
            bodyStyleTextField.text == nil {
            
            return "Please fill in all fiels!"
            
        }
        return nil
    }
    
    
    @IBAction func OkPressedButton(_ sender: UIButton) {
        if checkValid() != nil {
            errorLabel.text = checkValid()
            errorLabel.isHidden = false
        } else {
            addNewCar()
            navigationController?.popViewController(animated: true)
            
        }
    }
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        editButton.isEnabled = false
        editButton.tintColor = .white
        modelNameTextField.delegate = nil
        manufacturerTextField.delegate = nil
        yearOfProductionTextField.delegate = nil
        bodyStyleTextField.delegate = nil
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CarBodyStyle.allCases.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CarBodyStyle.allCases[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bodyStyleTextField.text = CarBodyStyle.allCases[row].rawValue
        bodyStyleTextField.resignFirstResponder()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return true
        } else {
            return false
        }
    }
}
