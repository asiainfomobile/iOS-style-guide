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
//        let resizeView1 = ResizeView()
//        view.addSubview(resizeView1)
//        
//        let resizeView2 = ResizeView()
//        view.addSubview(resizeView2)
    }
	
	override func updateViewConstraints() {
		super.updateViewConstraints()
	}
}

extension ResizeViewController: ResizeViewDelegate {
	func resizeView(resizeView: ResizeView, didClickAtIndex index: Int) {
	}
}
