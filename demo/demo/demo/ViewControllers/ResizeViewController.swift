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
	@IBOutlet weak var detailTextView: DetailTextView!
	@IBOutlet weak var tagListView: TagListView!
	override func viewDidLoad() {
		super.viewDidLoad()
		setupScrollView()
		setupResizeViews()
		setupBarButtonItem()
	}
	
	func setupBarButtonItem() {
		let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addTag")
		let changeTextBarButtonItem = UIBarButtonItem(title: "Change DetailTextView Text", style: .Done, target: self, action: "changeText")
		navigationItem.rightBarButtonItems = [addBarButtonItem, changeTextBarButtonItem]
	}
	
	func changeText() {
		detailTextView.text = "fdafdsaf"
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
