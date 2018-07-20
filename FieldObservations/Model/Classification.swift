//
//  Classification.swift
//  FieldObservations
//
//  Created by Jacob Sokora on 7/19/18.
//  Copyright © 2018 Jacob Sokora. All rights reserved.
//

import UIKit

enum Classification: String {
    case reptile
    case insect
    case plant
    case mammal
    case fish
    case amphibian
    case bird
    
    var image: UIImage? {
        get {
            return UIImage(named: rawValue)
        }
    }
}
