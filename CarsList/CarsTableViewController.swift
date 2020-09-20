//
//  CarsTableViewController.swift
//  CarsList
//
//  Created by Максим Солнцев on 9/16/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import UIKit
import RealmSwift

class CarsTableViewController: UITableViewController {
    
    let realm = try! Realm()
    lazy var carList: Results<Car> = { self.realm.objects(Car.self) }()
    let dbManager = DBManager()
    
    func defaultCars() {
        if carList.count == 0 {
            let car1 = Car()
            let car2 = Car()
            let car3 = Car()
            car1.setValuesForKeys(["nameManufacturer": "BMW", "nameModel": "M5", "yearOfProduction": "2020"])
            car1.bodyStyle = .Sedan
            car2.setValuesForKeys(["nameManufacturer": "Toyota", "nameModel": "Vitz", "yearOfProduction": "2010"])
            car2.bodyStyle = .Hatchback
            car3.setValuesForKeys(["nameManufacturer": "Porshche", "nameModel": "Panamaera", "yearOfProduction": "2015"])
            car3.bodyStyle = .Coupe
            dbManager.saveCar(car: car1)
            dbManager.saveCar(car: car2)
            dbManager.saveCar(car: car3)
            carList = realm.objects(Car.self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultCars()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarsListTableViewCell
        let cars = carList[indexPath.row]
        cell.fullCarNameLabel.text = cars.fullCarName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = self.carList[indexPath.row]
            dbManager.removeCar(car: item)
            tableView.reloadData()
        }    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditCarSegue" {
            let selectVC = segue.destination as! AddNewCarViewController
            selectVC.newCar = carList[tableView.indexPathForSelectedRow!.row]
            
        }
        
        if segue.identifier == "AddNewCarSegue" {
            let selectVC = segue.destination as! AddNewCarViewController
            selectVC.editButton.tintColor = .white
            selectVC.editButton.isEnabled = false
        }
    }
}



