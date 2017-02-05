//
//  RegistrationViewController.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/4/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

	@IBOutlet weak var loginButton: bpButton!
	@IBOutlet weak var tableView: UITableView!
	
	var isLogin = true
	
	fileprivate let _reuseIdentifier = "RegistrationCell"
	var emailAddress = ""
	var password = ""
	
    override func viewDidLoad() {
		Services.delegate = self
        super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = orangeColor
		tableView?.register(UINib(nibName: _reuseIdentifier, bundle: nil), forCellReuseIdentifier: _reuseIdentifier)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if isLogin {
			loginButton.setTitle("LOGIN", for: UIControlState())
		} else {
			loginButton.setTitle("REGISTER", for: UIControlState())
		}
		loginButton.applyTheme()
	}
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
	
	@IBAction func doAction(_ sender: Any) {
		self.view.endEditing(true)
		if emailAddress == "" || password == "" {
			bpNoActionAlert("Please enter your email and password", message: "")
			return
		}
		if isLogin {
			Services.loginUser(email: emailAddress, password: password)
		} else {
			Services.createUser(email: emailAddress, password: password)
			loginSuccess()
		}
	}
	
	func loginSuccess() {
		Services.fetchPools(userEmail: emailAddress)
		gblUserEmail = emailAddress
		self.performSegue(withIdentifier: "loginSegue", sender: nil)
	}

}

// MARK: Table view delegate and data source
extension RegistrationViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70.0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell	= tableView.dequeueReusableCell(withIdentifier: _reuseIdentifier) as! RegistrationCell
		cell.selectionStyle = .none
		cell.titleLabel.text = cell.titleLabel.text!.uppercased()
		cell.delegate = self
		
		if indexPath.row == 0 {
			cell.type = .email
			cell.titleLabel.text = "Email Address"
			cell.textField.keyboardType = .emailAddress
			cell.textField.isSecureTextEntry = false
			cell.textField.autocapitalizationType = .none
		} else if indexPath.row == 1 {
			cell.type = .password
			cell.titleLabel.text = "Password"
			cell.textField.keyboardType = .default
			cell.textField.isSecureTextEntry = true
			cell.textField.autocapitalizationType = .none
		}
		
		return cell
	}
}

extension RegistrationViewController : ServicesDelegate {
	internal func getPoolsCallback(success: Bool, pools: [Pool]) {
		
	}
	
	func loginCallback(success: Bool, message: String) {
		print("success", success, "message:", message)
		if success {
			loginSuccess()
		}
		else {
			bpNoActionAlert("Invalid Login", message: "")
		}
	}
}

extension RegistrationViewController : RegistrationCellDelegate {
	func didUpdateCellEntry(_ type: RegistrationCellType, text: String) {
		if type == .email {
			emailAddress = text
		} else if type == .password {
			password = text
		}
	}
	
}

