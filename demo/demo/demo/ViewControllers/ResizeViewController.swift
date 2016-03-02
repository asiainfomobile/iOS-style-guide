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
	@IBOutlet weak var tagListView: TagListView!
	override func viewDidLoad() {
		super.viewDidLoad()
		setupScrollView()
		setupResizeViews()
		setupBarButtonItem()
	}
	
	func setupBarButtonItem() {
		let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addTag")
		navigationItem.rightBarButtonItem = barButtonItem
	}
	func addTag() {
		
		let randomNumber = random() % 20
		var randomWord = ""
		
		for _ in 0 ... randomNumber {
			randomWord += "a"
		}
		
		UIView.animateWithDuration(1) { () -> Void in
			self.tagListView.tags.append(randomWord)
		}
	}
	
	func setupScrollView() {
		scrollView = UIScrollView()
		view.addSubview(scrollView)
	}
	
	func setupResizeViews() {
		tagListView.tags = ["first word", "second word", "third word"]
	}
	
	override func updateViewConstraints() {
		super.updateViewConstraints()
	}
}
