//
//  TableViewController.swift
//  Didgeridone
//
//  Created by Josue Ruchwarger on 2/18/16.
//  Copyright © 2016 Galvanize. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController{
    
    @IBOutlet weak var logout: UIBarButtonItem!
    
    //@IBOutlet weak var tableView: UITableViewCell!
    var toDoItems = [ToDoItem]()
    var selectedRow:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if toDoItems.count > 0 {
            return
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getData() {

        let defaults = NSUserDefaults.standardUserDefaults()
        let userID = defaults.stringForKey("UserID")
//        let token = defaults.stringForKey("Token")
        print(userID!)
        
        Alamofire.request(.GET, "https://didgeridone.herokuapp.com/task/\(userID!)").validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let tasks = json["user"]["tasks"]
                    
                    for (_, task) in tasks {
                        self.toDoItems.append((ToDoItem(text: task["name"].stringValue, longitude: task["long"].stringValue, latitude: task["lat"].stringValue)))
                    }
                    self.tableView.reloadData()
                    
                }
            case .Failure(let error):
                print(error)
            }
        }
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell",
                forIndexPath: indexPath)
            let item = toDoItems[indexPath.row]
            cell.textLabel?.text = item.text
            
            return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedRow = indexPath.row
        performSegueWithIdentifier("detailSegue", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let detailVC = segue.destinationViewController as! DetailViewController
        detailVC.todoItem = toDoItems[self.selectedRow]
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
