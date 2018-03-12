//
//  File.swift
//  UnitConverter
//
//  Created by Yoda Codd on 2018. 3. 9..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation
struct formulaSe{
    let lengthStepFirst : [String : Double] = ["m":100,"cm":1,"yard":91.44,"inch":2.54]
    let lengthStepSecond : [String : Double] = ["m":0.01,"cm":1,"yard":0.01,"inch":0.39]
    let weightStepFirst : [String : Double] = ["kg":1,"oz":35.27,"lb":0.45]
    let weightStepSecond : [String : Double] = ["kg":1,"oz":0.02,"lb":2.2]
}
print (formulaSe)
