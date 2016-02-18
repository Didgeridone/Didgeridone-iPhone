//
//  api.swift
//  Didgeridone
//
//  Created by Josue Ruchwarger on 2/17/16.
//  Copyright © 2016 Galvanize. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var toDoItems = [ToDoItem]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if toDoItems.count > 0 {
            return
        }
        
    }


func getData() {
    
    Alamofire.request(.GET, "https://didgeridone.herokuapp.com/task/56c3ad2db2273e8c7c9d3612").validate().responseJSON { response in
        switch response.result {
        case .Success:
            if let value = response.result.value {
                let json = JSON(value)
                let tasks = json["user"]["tasks"]
                
                for (_, task) in tasks {
                    self.toDoItems.append(ToDoItem(text: task["name"].stringValue))
                }
                self.tableView.reloadData()
                
            }
        case .Failure(let error):
            print(error)
        }
    }
    
}

func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
}

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDoItems.count
}

func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",
            forIndexPath: indexPath)
        let item = toDoItems[indexPath.row]
        cell.textLabel?.text = item.text
        
        return cell
}
}
