//
//  CarModel.swift
//  CarsList
//
//  Created by Максим Солнцев on 9/16/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Car: Object {
    
    dynamic var nameManufacturer = String()
    dynamic var nameModel = String()
    dynamic var fullCarName: String {
        return nameManufacturer + " " + nameModel
    }
    dynamic var yearOfProduction = String()
    dynamic var bodyStyleRawValue = String()
    dynamic var bodyStyle: CarBodyStyle? {
        get {return CarBodyStyle(rawValue: bodyStyleRawValue)}
        set {bodyStyleRawValue = newValue!.rawValue}
    }
}

enum CarBodyStyle: String, CaseIterable {
    case Coupe = "Coupe"
    case Hatchback = "Hatchback"
    case Sedan = "Sedan"
}




