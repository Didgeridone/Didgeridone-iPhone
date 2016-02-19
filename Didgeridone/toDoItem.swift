//
//  toDoItem.swift
//  Didgeridone
//
//  Created by Josue Ruchwarger on 2/18/16.
//  Copyright © 2016 Galvanize. All rights reserved.
//

import UIKit

class ToDoItem {
   
    // A text description of this item.
    var text: String?
    
    // A Boolean value that determines the completed state of this item.
    var completed: Bool
    
    var latitude: String?
    var longitude: String?
    
    // Returns a ToDoItem initialized with the given text and default completed value.
    init(text: String, longitude: String, latitude: String) {
        self.text = text
        self.latitude = latitude
        self.longitude = longitude
        self.completed = false
    }

}
