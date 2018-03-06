//
//  main.swift
//  UnitConverter
//
//  Created by Yoda Codd on 2018. 3. 5..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation
// 계속 쓰이는 단위 100 을 상수로 지정
let hund:Double = 100

//String 값을 입력 받아서 문자열을 출력하는 함수
func UnitConverter (inputString: String) -> String {
    //입력값에서 문자열만 남는 변수
    var onlyString : String = ""
    //입력값에서 숫자 문자열만 남는 변수
    var onlyNumberString : String = ""
    //입력값을 배열 칸마다 배치
    let inputStringArr = inputString
    //배열 한글자 마다 숫자인지 알파벳인지 체크
    for tempChar in inputStringArr {
        // 알파벳이면 onlyString 에 추가
        if (tempChar >= "a" && tempChar <= "z") || (tempChar >= "A" && tempChar <= "Z") {
            onlyString += String(tempChar)
        }
        // 숫자 혹은 . 이면 onlyNumberString 에 추가
        else if(tempChar >= "0" && tempChar <= "9" || tempChar == ".")  {
            onlyNumberString += String(tempChar)
        }
    }
    //숫자만 자른 숫자 string 을 더블타입으로 변환
    let inputNum = (onlyNumberString as NSString).doubleValue
    //문자열을 체크
    switch onlyString{
    //cm 이면 100 으로 나누고 m 을 붙여서 리턴
    case "cm" :
        return ("\(inputNum/hund)m")
    // cm 이면 100을 곱해주고 cm을 붙여서 리턴
    case "m" :
        return ("\(Int(inputNum*hund))cm")
        
    default : break
    }
    //위의 switch 구문에서 break 가 나지 않으면 fail 구문 출력
    return ("wrong input")
}
//유저 입력을 받기 위해 입력을 요청
print("Please enter size : ", terminator: "")
//유저 입력을 받아서 userInput 에 입력
let userInput = readLine()!
//UnitConverter 함수에 유저 입력을 입력
print(UnitConverter(inputString : userInput ))

