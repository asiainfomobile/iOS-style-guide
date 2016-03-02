//
//  ResizeViewController.swift
//  demo
//
//  Created by admin on 3/1/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit

class ResizeViewController: UIViewController {
	var scrollView: UIScrollView!
	override func viewDidLoad() {
		super.viewDidLoad()
		setupScrollView()
        setupResizeViews()
	}
	
	func setupScrollView() {
		scrollView = UIScrollView()
		view.addSubview(scrollView)
	}
    
    func setupResizeViews() {
        

    }
	
	override func updateViewConstraints() {
		super.updateViewConstraints()
	}
}
