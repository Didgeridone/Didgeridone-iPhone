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
    
    func authenticate(){
        Alamofire.request(.POST, "https://didgeridone.herokuapp.com/auth/login" ){
            .authenticate(HTTPBasic: email, password: password)
            .responseJSON {(request, response, JSON, error) in
                println(request)
                println(response)
                println(JSON)
                println(error)
            }
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
