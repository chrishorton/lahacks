//
//  CreateViewController.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/5/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

	fileprivate let _reuseIdentifier = "CreatePoolCellTableViewCell"
	@IBOutlet weak var tableView: UITableView!
	var pool = Pool()
	
	override func viewDidLoad() {
		Services.delegate = self
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = orangeColor
		tableView.register(UINib(nibName: _reuseIdentifier, bundle: nil), forCellReuseIdentifier: _reuseIdentifier)
		pool.memberIds.append(gblUserEmail)
		self.title = "CREATE POOL"
	}

	@IBAction func doAction(_ sender: Any) {
		self.view.endEditing(true)
		if pool.contribution > 0 && pool.intervalInDays != 0 && pool.memberIds.count > 1 {
			pool.id = UUID().uuidString
			gblPools.append(pool)
			Services.createPoolOnFB(pool: pool)
			self.navigationController?.popViewController(animated: true)
		} else {
			bpNoActionAlert("Fill out all fields", message: "")
		}
	}
}

// MARK: Table view delegate and data source
extension CreateViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return CreateCellType.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70.0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell	= tableView.dequeueReusableCell(withIdentifier: _reuseIdentifier) as! CreatePoolCellTableViewCell
		cell.selectionStyle = .none
		cell.delegate = self
		
		let type = CreateCellType(rawValue: indexPath.row)!
		cell.type = type
		switch (type) {
		case .name:
			cell.textField.placeholder = "Name"
		case .contribution:
			cell.textField.placeholder = "Contribution"
		case .interval:
			cell.textField.placeholder = "Pay-in Interval"
		case .member:
			cell.textField.placeholder = "Add a member"
		}
		
		return cell
	}
}

extension CreateViewController : ServicesDelegate {
	internal func getPoolsCallback(success: Bool, pools: [Pool]) {
		
	}
	
	func loginCallback(success: Bool, message: String) {
		print("success", success, "message:", message)
	}
}

extension CreateViewController : CreateCellDelegate {
	func didUpdateCellEntry(_ type: CreateCellType, text: String) {
		switch type {
		case .contribution:
			if let int = Int(text) {
				pool.contribution = int
			} else {
				bpNoActionAlert("Please enter a number", message: "")
			}
		case .interval:
			if let int = Int(text) {
				pool.intervalInDays = int
			} else {
				bpNoActionAlert("Please enter a number", message: "")
			}
		case .member:
			if text != "" {
				pool.memberIds.append(text)
				let cell = tableView.visibleCells[3] as! CreatePoolCellTableViewCell
				cell.textField.text = ""
				bpNoActionAlert("Member added", message: "Add another member by typing in the same textfield")
			} else {
				bpNoActionAlert("Please enter an email address", message: "")
			}
		case .name:
			if text != "" {
				pool.name = text
			} else {
				bpNoActionAlert("Please enter a name", message: "")
			}
		}
	}
	
}
