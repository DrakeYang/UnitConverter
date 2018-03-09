//
//  main.swift
//  unitConverter
//
//  Created by Yoda Codd on 2018. 3. 5..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation
// 단위를 구조체로 정리
func calculateLength(number : Double ,from : String, to : String) -> String{
    // Cm To Meter 단위 저장
    let cmToMeter : Double = 0.01
    // M to Cm 단위 저장
    let meterToCm : Double = 100
    // inch to cm 단위 저장
    let inchToCm : Double = 2.54
    // cm to inch 단위 저장
    let cmToInch : Double = 0.39
    // inch to meter
    let inchToMeter : Double = 0.02
    // inch to yard
    let inchToYard : Double = 0.02
    //yard to inch
    let yardToInch : Double = 36
    // m to inch 단위 저장
    let meterToInch : Double = 39.37
    // cm to yard 단위 저장
    let cmToYard : Double = 0.01
    // yard to cm  단위 저장
    let yardToCm : Double = 91.44
    
    // 값을 딕셔너리에 정리
    let beforeCmMultiplier : [String : Double] = ["m":100,"cm":1,"yard":91.44,"inch":2.54]
    let afterCmMuliplier : [String : Double] = ["m":0.01,"cm":1,"yard":0.01,"inch":0.39]

    //error message
    let errorMessage : String = "지원하지 않는 단위입니다."
    
    // 입력 단위 기준으로 계산 시작
    switch from {
    // 입력단위가 cm 일때
    case "cm" :
        //변환할 단위
        switch to {
        case "m" :
            return ("\(number * cmToMeter)\(to)")
        case "" :
            return ("\(number * cmToMeter)m")
        case "inch" :
            return ("\(number * cmToInch)\(to)")
        case "yard" :
            return ("\(number * cmToYard)\(to)")
        default : return(errorMessage)
        }
    // 입력단위가 m 일때
    case "m" :
        switch to {
        case "cm" :
            return ("\(number * meterToCm)\(to)")
        case "" :
            return ("\(number * meterToCm)cm")
        case "inch" :
            return ("\(number * meterToInch)\(to)")
        case "yard" :
            return ("\(number * meterToCm * cmToMeter)\(to)")
        default : return(errorMessage)
        }
        // 입력단위가 inch 일때
    case "inch" :
        switch to {
        case "cm" :
            return ("\(number * inchToCm)\(to)")
        case "m" :
            return ("\(number * inchToMeter)\(to)")
        case "yard" :
            return ("\(number * inchToYard)\(to)")
        default : return(errorMessage)
        }
        // 입력단위가 yard 일때
    case "yard" :
        switch to {
        case "cm" :
            return ("\(number * yardToCm)\(to)")
        case "m" :
            return ("\(number * yardToCm * cmToMeter)\(to)")
        case "inch" :
            return ("\(number * yardToInch)\(to)")
        default : print(errorMessage)
        }
    default : return(errorMessage)
    }
    return errorMessage
}

// 무게 계산용 함수
func calculateWeight(number : Double ,from : String, to : String) -> String{
    // oz to kg 단위 저장
    let ozToKg : Double = 0.02
    // kg to oz 단위 저장
    let kgToOz : Double = 35.27
    // lb to kg 단위 저장
    let lbToKg : Double = 0.45
    // kg to lb  단위 저장
    let kgToLb : Double = 2.2
    // lb to oz
    let lbToOz : Double = 16
    //oz to lb
    let ozToLb : Double = 0.06
    //error message
    let errorMessage : String = "지원하지 않는 단위입니다."
    // 변환할 단위로 분기 시작
    switch from {
        //입력 단위가 kg 일때
    case "kg" :
        switch to {
        case "oz" :
            return ("\(number * kgToOz)\(to)")
        case "lb" :
            return ("\(number * kgToLb)\(to)")
        default : return(errorMessage)
        }
        // 입력단위가 oz
    case "oz" :
        switch to {
        case "kg" :
            return ("\(number * ozToKg)\(to)")
        case "lb" :
            return ("\(number * ozToLb)\(to)")
        default : return(errorMessage)
        }
        // 입력단위가 lz
    case "lb" :
        switch to {
        case "kg" :
            return ("\(number * lbToKg)\(to)")
        case "oz" :
            return ("\(number * lbToOz)\(to)")
        default : return(errorMessage)
        }
    default : return (errorMessage)
    }
}

//유저 입력을 받는 함수
func recieveUserInput()->String {
    //유저 입력을 받기 위해 입력을 요청
    print("Please enter size : ", terminator: "")
    //유저 입력을 받아서 userInput 에 입력
    if let userInput = readLine(){
        return userInput
    }
    else {
        print ("입력이 없습니다")
        return ("q")
    }
    
}

// 입력값을 숫자와 문자로 나누는 함수
// 입력값을 받아서 튜플형태로 리턴
func divideUserinput(tempInput : String)->(String , String , String){
    // 입력받은 수치 변수
    var inputSize : String = ""
    // 입력받은 단위 변수
    var inputMeasure : String = ""
    // 변환하려는 단위 변수
    var targetMeausure : String = ""
    // 입력받은 수치,단위,변환단위를 나눠주는 기준 변수
    var checkDivide : Int = 0
    
    //입력받은 문자열에서 한글자씩 추출
    for tempChar in tempInput {
        switch checkDivide {
        case 0 :
            // 숫자 혹은 . 만 모아서 inputSize 에 추가
            if(tempChar >= "0" && tempChar <= "9" || tempChar == ".")  {
                inputSize += String(tempChar)
                // 그 외의 문자면 checkDivide + 해주고 이후의 입력은 inputMeasure 로 들어감
            } else {
                checkDivide += 1
                inputMeasure += String(tempChar)
            }
            
        // 입력받은 단위를 저장하는 부분
        case  1 :
            // 공백이 입력되면 다음단계로 넘어간다
            if(tempChar == " ") {
                checkDivide += 1
            }
                // 공백이 아니라면 단위에 추가함
            else {
                inputMeasure += String(tempChar)
            }
            
        //공백 이후의 모든 문자는 targetMeausure 에 추가됨
        default :
            targetMeausure += String(tempChar)
        }
    }
    // 완성된 3가지 String 을 튜플 형태로 리턴
    return (inputSize , inputMeasure , targetMeausure)
}

//숫자,입력된 단위, 목표단위를 입력받아 계산해서 출력해주는 함수
func multiplier(number : Double , from : String , to : String , define : Double) -> String{
    return("\(number*define)\(to)")
}

//변환할 단위가 없을 경우 사용하는 함수
func measureTransformNoTarget(number : Double,originMeasure : String , targetMeasure : String  ) -> String {
    return ("\(calculateLength(number: number, from: originMeasure, to: targetMeasure))\(targetMeasure)")
    }

//변환 단위가 무게인지 길이인지 체크
func checkMeasureType(inputMeasureType : String) -> String{
    let kindOfLength = ["m","cm","inch","yard"]
    let kindOfWeight = ["kg","oz","lb"]
    if kindOfLength.contains(inputMeasureType){
        return ("length")
    }
    else if kindOfWeight.contains(inputMeasureType){
        return ("weight")
    }
    else {
        return ("out of support")
    }
}

//변환할 단위가 길이인 경우 함수
//함수의 인자 : 입력받은 수치, 원래 단위, 변환할 단위
func measureTransformWithLength(oringSize : Double , originMeasure : String, toMeasure : String) -> String{
    return calculateLength(number: oringSize, from: originMeasure, to: toMeasure)
    }

//변환할 단위가 무게인 경우 함수
//함수의 인자 : 입력받은 수치, 원래 단위, 변환할 단위
func measureTransformWithWeight(oringSize : Double , originMeasure : String, toMeasure : String) -> String{
    return calculateWeight(number: oringSize, from: originMeasure, to: toMeasure)
}

//변환 출력 함수 실행 함수
func printResult(oringSize : Double , originMeasure : String, toMeasure : String) {
    // 변환단위가 없으면 단위 없는 변환함수 사용
    if toMeasure == "" {
        print(measureTransformNoTarget(number : oringSize , originMeasure : originMeasure , targetMeasure: toMeasure))
    }
        // 변환단위가 있으면 단위 있는 변환함수 사용
    else {
        switch checkMeasureType(inputMeasureType : originMeasure) {
        case "length" :
            print(measureTransformWithLength(oringSize: oringSize, originMeasure: originMeasure, toMeasure: toMeasure))
            
        case "weight" :
            print(measureTransformWithWeight(oringSize: oringSize, originMeasure: originMeasure, toMeasure: toMeasure))
        default :
            print ("지원하지 않는 단위입니다.")
        }
    }
}


//반복문 시작
while true {
    //유저가 데이터 입력
    let userInput : String = recieveUserInput()
    if userInput == "q" || userInput == "quit" {
        break
    }
    
    // 위의 함수로 변환한 값을 각각의 변수에 입력
    let (inputSize , inputMeasure , targetMeasure) = divideUserinput(tempInput : userInput)
    
    //숫자만 자른 숫자 string 을 더블타입으로 변환. 아무값 없다면 0으로 치환됨
    let inputNumber = (inputSize as NSString).doubleValue
    
    //출력 실행
    printResult(oringSize: inputNumber, originMeasure: inputMeasure, toMeasure: targetMeasure)
}

