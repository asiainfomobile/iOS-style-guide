//
//  LinearLayoutViewController.swift
//  demo
//
//  Created by admin on 2/29/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit
import SnapKit

class LinearLayoutViewController: UIViewController {
	
	var lastView: UIView!
	var hasLoadedConstraints = false
	var margin: CGFloat = 10
	var viewHeight: CGFloat = 100
	var numberOfViews = 1
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		lastView = UIView()
		lastView.backgroundColor = UIColor.redColor()
		lastView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(lastView)
		
		let navigationBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonClick")
		navigationItem.rightBarButtonItem = navigationBarButtonItem
	}
	
	func addButtonClick() {
		let v = UIView()
		v.backgroundColor = UIColor.redColor()
		v.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(v)
		
		numberOfViews++
		
		v.snp_makeConstraints { (make) -> Void in
			make.centerY.equalTo(view)
			make.leading.equalTo(lastView.snp_trailing).offset(margin)
			make.height.equalTo(viewHeight)
			make.width.equalTo(lastView)
			make.trailing.equalTo(view).offset(-margin).priority(numberOfViews)
		}
		
		lastView = v
		
		v.layoutIfNeeded()
}
	
	override func updateViewConstraints() {
		
		if (!hasLoadedConstraints) {
			hasLoadedConstraints = true;
			lastView.snp_makeConstraints(closure: { (make) -> Void in
				make.centerY.equalTo(view)
				make.leading.equalTo(view).offset(margin)
				make.height.equalTo(viewHeight)
				make.trailing.equalTo(view).offset(-margin).priority(numberOfViews)
			})
		}
		super.updateViewConstraints()
	}
}
