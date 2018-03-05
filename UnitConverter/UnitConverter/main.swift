//
//  main.swift
//  UnitConverter
//
//  Created by Yoda Codd on 2018. 3. 5..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation

let hund:Double = 100
var cen = 160
var met = (Double(cen))/Double(hund)
//print(met)

var input = "167cm"
if input.contains("cm"){
    let inputArr = input.components(separatedBy:"cm")
    let inputStr : String = inputArr[0]
    let inputNum = (inputStr as NSString).doubleValue
    print(inputNum/hund,"m")
}
else if input.contains("m"){
    let inputArr = input.components(separatedBy:"m")
    let inputStr : String = inputArr[0]
    let inputNum = (inputStr as NSString).doubleValue
    print(Int(inputNum*hund),"cm")
}
