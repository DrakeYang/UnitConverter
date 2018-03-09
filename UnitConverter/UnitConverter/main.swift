//
//  main.swift
//  unitConverter
//
//  Created by Yoda Codd on 2018. 3. 5..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation

// 숫자 현제단위 변경단위 를 입력받아 곱셈하는 함수
func multiplier(inputOne : Double ,inputTwo : Double, inputThree : Double) -> Double{
    return (inputOne * inputTwo * inputThree)
}

//에러메세지 출력 함수
func returnErrorMessage() -> String{
    return ("지원하지 않는 단위입니다.")
}

// 숫자와 닐체크 필요한 두 변수를 받아서 둘다 아니면 곱셈값 리턴 하나라도 닐이면 에러메세지 리턴
func checkNilMultiplier(number : Double, second : Double?, third : Double?, targetMeasure : String) -> String{
    if let nilCheckSecond = second , let nilCheckThird = third  {
        return ("\(multiplier(inputOne: number, inputTwo: nilCheckSecond, inputThree: nilCheckThird))\(targetMeasure)")
    }
    else {
        return returnErrorMessage()
    }
}

// 계산용 공식을 저장하는 구조체
//구체적인 공식내용은 딕셔너리로 정리
struct formulaSe{
    let lengthStepFirst : [String : Double] = ["m":100,"cm":1,"yard":91.44,"inch":2.54]
    let lengthStepSecond : [String : Double] = ["m":0.01,"cm":1,"yard":0.01,"inch":0.39]
    let weightStepFirst : [String : Double] = ["kg":1,"oz":35.27,"lb":0.45]
    let weightStepSecond : [String : Double] = ["kg":1,"oz":0.02,"lb":2.2]
}

// 단위를 구조체로 정리
func calculateLength(number : Double ,from : String, to : String) -> String{
    // 값을 딕셔너리에 정리
    let beforeCmMultiplier : [String : Double] = ["m":100,"cm":1,"yard":91.44,"inch":2.54]
    let afterCmMuliplier : [String : Double] = ["m":0.01,"cm":1,"yard":0.01,"inch":0.39]
    
    // 곱하기 함수를 이용하여 결과 리턴. 딕셔너리에 없는 값일 경우 체크해서 else 문으로 보낸다.
    return ("\(checkNilMultiplier(number: number, second: beforeCmMultiplier[from], third: afterCmMuliplier[to],targetMeasure : to))")
}

// 무게 계산용 함수
func calculateWeight(number : Double ,from : String, to : String) -> String{
    // 각 배율을 저장하는 변수
    let beforeKgMultiplier : [String : Double] = ["kg":1,"oz":35.27,"lb":0.45]
    let afterKgMuliplier : [String : Double] = ["kg":1,"oz":0.02,"lb":2.2]
    
    // 곱하기 함수를 이용하여 결과 리턴. 딕셔너리에 없는 값일 경우 체크해서 else 문으로 보낸다.
    return ("\(checkNilMultiplier(number: number, second: beforeKgMultiplier[from], third: afterKgMuliplier[to],targetMeasure : to))")
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
        return returnErrorMessage()
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
            print (returnErrorMessage())
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

