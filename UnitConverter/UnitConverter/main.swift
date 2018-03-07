//
//  main.swift
//  unitConverter
//
//  Created by Yoda Codd on 2018. 3. 5..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation
// 계속 쓰이는 단위 100 을 상수로 지정
let measureHundred:Double = 100

//유저 입력을 받는 함수
func recieveUserInput()->String {
    //유저 입력을 받기 위해 입력을 요청
    print("Please enter size : ", terminator: "")
    //유저 입력을 받아서 userInput 에 입력
    let userInput = readLine()!
    return userInput
}
//유저가 데이터 입력
let userInput : String = recieveUserInput()


// 입력값을 숫자와 문자로 나누는 함수
// 입력값을 받아서 튜플형태로 리턴
func divideUserinput(tempInput:String)->(String,String){
    var inputMeasure : String = ""
    var inputSize : String = ""
    var checkDivide : Int = 0
    for tempChar in tempInput {
        // 숫자 혹은 . 만 모아서 리턴
        if checkDivide == 0 {
            if(tempChar >= "0" && tempChar <= "9" || tempChar == ".")  {
                inputSize += String(tempChar)
            } else {
                checkDivide += 1
                inputMeasure += String(tempChar)
            }
        }
        else {inputMeasure += String(tempChar)
        }
    }
    return (inputSize,inputMeasure)
}
let (inputSize , inputMeasure) = divideUserinput(tempInput:userInput)

//숫자만 자른 숫자 string 을 더블타입으로 변환
let inputNumber = (inputSize as NSString).doubleValue

//cm 을 m 로 바꿔서 출력
func cmToMeter(cmNumber : Double) -> String{
    return ("\(cmNumber/measureHundred)m")
}
//m 를 cm 으로 바꿔서 출렷
func meterToCm(meterNumber : Double) -> String{
    return ("\(Int(meterNumber*measureHundred))cm")
}
//m > cm , cm > m 변환 출력 함수
func measureTransform(measure : String) -> String {
    switch measure{
    //cm 이면 100 으로 나누고 m 을 붙여서 리턴
    case "cm" :
        return (cmToMeter(cmNumber : inputNumber))
    // cm 이면 100을 곱해주고 cm을 붙여서 리턴
    case "m" :
        return (meterToCm(meterNumber : inputNumber))
    // 주어진 값 이외의 값이면 잘못된 단위 라는 메세지 출력
    default : return("wrong measure")
    }
}
//변환 출력 함수 실행 함수
func printResult() {
    print(measureTransform(measure: inputMeasure))
}
//출력 실행
printResult()



