//: Playground - noun: a place where people can play

import UIKit

struct Address {
    var streetAddress: String
    var city: String
    var state: String
    var postalCode: String
}
struct AddressBits {
    let underlyingPtr: UnsafeMutablePointer<Void>
    let padding1: Int
    let padding2: Int
    let padding3: String
    let padding4: String
    let padding5: String
}
var test1 = Address(streetAddress: "1 King Way", city: "Kings Landing", state: "Westeros", postalCode: "12345")
var test2 = Address(streetAddress: "1 King Way", city: "Kings Landing", state: "Westeros", postalCode: "12345")
var test3 = Address(streetAddress: "1 King Way", city: "Kings Landing", state: "Westeros", postalCode: "12345")

let bits1 = unsafeBitCast(test1, AddressBits.self)
let bits2 = unsafeBitCast(test2, AddressBits.self)
let bits3 = unsafeBitCast(test3, AddressBits.self)

bits1.underlyingPtr
bits2.underlyingPtr
bits3.underlyingPtr

let v1 = UIView()
let v2 = UIView()

var ddsaf: String? = "fdas"

if let ddsaf = ddsaf {
    print(ddsaf)
}
