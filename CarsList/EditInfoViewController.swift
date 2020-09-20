//
//  EditInfoViewController.swift
//  CarsList
//
//  Created by Максим Солнцев on 9/17/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import UIKit

class EditInfoViewController: UIViewController {

    @IBOutlet weak var manufacturerTextField: UITextField!
    @IBOutlet weak var modelNameTextField: UITextField!
    @IBOutlet weak var yearOfProducedTextField: UITextField!
    @IBOutlet weak var bodyStyleTextField: UITextField!
    @IBOutlet weak var OkEditButton: UIButton!
    @IBOutlet weak var errorEditLabel: UILabel!
    
    var selectCar = Car()
    let dbManager = DBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(selectCar.bodyStyle)
        
        OkEditButton.isHidden = true
        errorEditLabel.isHidden = true
        manufacturerTextField.isEnabled = false
        modelNameTextField.isEnabled = false
        yearOfProducedTextField.isEnabled = false
        bodyStyleTextField.isEnabled = false
        
        manufacturerTextField.text = selectCar.nameManufacturer
        modelNameTextField.text = selectCar.nameModel
        yearOfProducedTextField.text = selectCar.yearOfProduction
       
        switch selectCar.bodyStyle {
        case .Coupe:
            bodyStyleTextField.text = "Coupe"
        case .Hatchback:
            bodyStyleTextField.text = "Hatchback"
        case .Sedan:
            bodyStyleTextField.text = "Sedan"
        default:
            bodyStyleTextField.text = "Unknowed body style"
        }
    }
    
    func checkValid() -> String? {
          if manufacturerTextField.text == "" ||
              modelNameTextField.text == "" ||
              yearOfProducedTextField.text == "" ||
              bodyStyleTextField.text == "" ||
              manufacturerTextField.text == nil ||
              modelNameTextField.text == nil ||
              yearOfProducedTextField.text == nil ||
              bodyStyleTextField.text == nil {
              
              return "Please fill in all fiels!"
              
          }
          return nil
      }
    
    func editCar() {
        selectCar.nameModel = modelNameTextField.text!
        selectCar.nameManufacturer = manufacturerTextField.text!
        selectCar.yearOfProduction = yearOfProducedTextField.text!
        switch bodyStyleTextField.text {
        case "Coupe":
            selectCar.bodyStyle = .Coupe
        case "Hatchback":
            selectCar.bodyStyle = .Hatchback
        case "Sedan":
            selectCar.bodyStyle = .Sedan
        default:
            break
        }
        
        
        dbManager.saveCar(car: selectCar)
    }
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        OkEditButton.isHidden = false
        manufacturerTextField.isEnabled = true
        modelNameTextField.isEnabled = true
        yearOfProducedTextField.isEnabled = true
        bodyStyleTextField.isEnabled = true
    }
    
    @IBAction func OkPressed(_ sender: UIButton) {
        if checkValid() != nil {
            errorEditLabel.text = checkValid()
            errorEditLabel.isHidden = false
        } else {
            editCar()
            navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    
    
}
