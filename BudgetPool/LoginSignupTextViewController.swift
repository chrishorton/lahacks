//
//  LoginSignupTextViewController.swift
//  BudgetPool
//
//  Created by Christopher Horton on 2/4/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import UIKit

class LoginSignupTextViewController: UIViewController {

    @IBOutlet weak var MutableTextLabel: UIButton!
    var loginIdentifier = " "

    override func viewDidLoad() {
        super.viewDidLoad()
        getLoginOrSignUpInfo(identifier: loginIdentifier)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getLoginOrSignUpInfo(identifier: String) {
        if identifier == "LogIn" {
            MutableTextLabel.setTitle("Log In", for: UIControlState())
        }
        
        if identifier == "SignUp" {
            MutableTextLabel.setTitle("Sign Up", for: UIControlState())
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
