//
//  DBManager.swift
//  CarsList
//
//  Created by Максим Солнцев on 9/16/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    fileprivate lazy var realm = try! Realm()
    
    func saveCar(car: Car) {
        try! realm.write {
            realm.add(car)
        }
    }
    
    func removeCar(car: Car) {
        try! realm.write {
            realm.delete(car)
        }
    }
    
}
