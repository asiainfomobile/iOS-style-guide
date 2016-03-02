//
//  TagListViewController.swift
//  demo
//
//  Created by admin on 3/1/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit

class TagListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tagListView = TagListView(tags: ["111111111111111word","222222222second word","3333333third word","4444444first word","55555555second word","666666666second word","77777777third word","88888888first word","9second word"])
        view.addSubview(tagListView)
        tagListView.backgroundColor = UIColor.grayColor()
        
        tagListView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(view).offset(80)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
