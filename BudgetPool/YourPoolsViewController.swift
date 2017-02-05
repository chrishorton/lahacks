//
//  YourPoolsViewController.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/5/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import UIKit

class YourPoolsViewController: UIViewController {

	let reuseIdentifier = "PoolCell"
	let kCellHeight = 220
	var selectedPool : Pool!
	
	@IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView?.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
		collectionView?.delegate				= self
		collectionView?.dataSource				= self
		collectionView?.backgroundColor			= UIColor.clear
		collectionView?.alwaysBounceVertical	= true

		self.title = "YOUR POOLS"
    }
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("gblPools: ", gblPools)
		collectionView.reloadData()
	}
}


extension YourPoolsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	// MARK: - Collection View delegate and data source and flow layout delegate
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return gblPools.count
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let selectedPool = gblPools[indexPath.row]
		let cell = collectionView.cellForItem(at: indexPath) as! PoolCell
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PoolCell
		
		return cell
	}
	
	//make sure that it's two columns of cells
	func collectionView(_ collectionView: UICollectionView,
	                    layout collectionViewLayout: UICollectionViewLayout,
	                    sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.size.width / 2 - 24, height: CGFloat(kCellHeight))
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 17
	}
}
