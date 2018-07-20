//
//  ObservationLoader.swift
//  FieldObservations
//
//  Created by Jacob Sokora on 7/19/18.
//  Copyright © 2018 Jacob Sokora. All rights reserved.
//

import Foundation

class ObservationLoader {
    static let dateFormatter = DateFormatter()
    
    class func load(fileName: String) -> [FieldObservation] {
        var observations = [FieldObservation]()
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            observations = parse(data)
        }
        
        return observations
    }
    
    class func parse(_ data: Data) -> [FieldObservation] {
        var fieldObservations = [FieldObservation]()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let root = json as? [String: Any],
            let status = root["status"] as? String,
            status == "ok" {
            
            if let observations = root["observations"] as? [Any] {
                for observation in observations {
                    if let observation = observation as? [String: String] {
                        if let classification = observation["classification"],
                            let title = observation["title"],
                            let description = observation["description"],
                            let dateString = observation["date"],
                            let date = dateFormatter.date(from: dateString) {
                            
                            if let fieldObservation = FieldObservation(classificationName: classification, title: title, description: description, date: date) {
                                fieldObservations.append(fieldObservation)
                            }
                        }
                    }
                }
            }
            
        }
        
        return fieldObservations
    }
}
