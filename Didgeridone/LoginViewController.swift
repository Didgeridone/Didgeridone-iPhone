//
//  LoginViewController.swift
//  Didgeridone
//
//  Created by Josue Ruchwarger on 2/18/16.
//  Copyright © 2016 Galvanize. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(sender: UIButton!) {
        let parameters = [
            "email": email.text!,
            "password": password.text!
        ]
        
        Alamofire.request(.POST, "https://didgeridone.herokuapp.com/auth/login", parameters: parameters, encoding: .JSON  )
            .responseJSON {(response) in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = JSON(value)
                        let userID = data["user"]["_id"]
                        let token = data["token"]
                        
//                        enum defaultsKeys {
//                            static let userId = user
//                            static let token = tokenId
//                        }
                        
                        let defaults = NSUserDefaults.standardUserDefaults()
                        
                        defaults.setValue(String(userID), forKey: "UserID")
                        defaults.setValue(String(token), forKey: "Token")
                        defaults.synchronize()
                    }
                case .Failure(let error):
                    print(error)
                
                }

            self.performSegueWithIdentifier("tasks", sender: sender)
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
