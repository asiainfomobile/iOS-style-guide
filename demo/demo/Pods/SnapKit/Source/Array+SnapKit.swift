//
//  Array+SnapKit.swift
//  SnapKit
//
//  Created by admin on 3/3/16.
//  Copyright © 2016 SnapKit Team. All rights reserved.
//

import UIKit

extension Array {
	
	public func snp_makeConstraints(file: String = __FILE__, line: UInt = __LINE__, @noescape closure: (make: ConstraintMaker) -> Void) -> Void {
		guard let _ = self.first as? UIView else {
			// All objects in the array must be views
			return
		}
		for v in self {
			(v as! UIView).snp_makeConstraints(file, line: line, closure: closure)
		}
	}
	
	public func snp_updateConstraints(file: String = __FILE__, line: UInt = __LINE__, @noescape closure: (make: ConstraintMaker) -> Void) -> Void {
		guard let _ = self.first as? UIView else {
			// All objects in the array must be views
			return
		}
		for v in self {
			(v as! UIView).snp_updateConstraints(file, line: line, closure: closure)
		}
	}
	
	public func snp_remakeConstraints(file: String = __FILE__, line: UInt = __LINE__, @noescape closure: (make: ConstraintMaker) -> Void) -> Void {
		guard let _ = self.first as? UIView else {
			// All objects in the array must be views
			return
		}
		for v in self {
			(v as! UIView).snp_remakeConstraints(file, line: line, closure: closure)
		}
	}
}
