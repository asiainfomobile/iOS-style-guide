//
//  TimeLineViewController.swift
//  demo
//
//  Created by admin on 3/1/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController {
    
    var timeLineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLineView = UINib(nibName: "TimeLineView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        timeLineView.contentMode = .Redraw
        view.addSubview(timeLineView)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        timeLineView.snp_remakeConstraints { (make) -> Void in
            make.edges.equalTo(view).offset(UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0))
        }
    }
}
