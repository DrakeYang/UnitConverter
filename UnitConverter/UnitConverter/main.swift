//
//  main.swift
//  unitConverter
//
//  Created by Yoda Codd on 2018. 3. 5..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation

// 숫자 셋을 입력받아 곱셈하는 함수
func multiplier(inputOne : Double ,inputTwo : Double, inputThree : Double) -> Double{
    return (inputOne * inputTwo * inputThree)
}

//에러메세지 출력 함수
func returnErrorMessage() -> String{
    return ("지원하지 않는 단위입니다.")
}

// 계산용 공식을 저장하는 구조체
//구체적인 공식내용은 딕셔너리로 정리
struct FormulaSet{
    let formula = ["length" : ["inWorking" :["m":100.0,"cm":1.0,"yard":91.44,"inch":2.54]
                            , "outWorking" : ["m":0.01,"cm":1.0,"yard":0.01,"inch":0.39]]
                ,"weight" : ["inWorking" : ["kg":1.0,"oz":35.27,"lb":0.45]
                            , "outWorking" : ["kg":1.0,"oz":0.02,"lb":2.2]]]
    
    func checkType(inputMeasure : String) -> String?  {
        for type in formula.keys{
            if formula[type]?["inWorking"]?[inputMeasure] != nil {
                return type
            }
        }
        return nil
    }
    func returnFormularNumber(type : String, inMeasure : String,outMeasure : String) -> (Double,Double)?{
        if let inFormula = formula[type]?["inWorking"]?[inMeasure] ,let outFormula = formula[type]?["outWorking"]?[outMeasure] {
            return (inFormula,outFormula)
        }
        return nil
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
    return ""
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

//변환할 단위가 없는경우를 위한 함수
func fillEmptyTargetMeasure(inputMeasure : String, targetMeasure : String)-> String {
    if inputMeasure == "cm" && targetMeasure == "" {
        return "m"
    }
    else if inputMeasure == "m" && targetMeasure == "" {
        return "cm"
    }
    else {
        return targetMeasure
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
    var (inputSize , inputMeasure , targetMeasure) = divideUserinput(tempInput : userInput)
    
    // 구조체 선언
    let formula = FormulaSet()
    
    //숫자만 자른 숫자 string 을 더블타입으로 변환. 아무값 없다면 0으로 치환됨
    let inputNumber = (inputSize as NSString).doubleValue
    
    //targetMeasure 가 비어있을 경우를 위해서 함수 실행.
    targetMeasure = fillEmptyTargetMeasure(inputMeasure : inputMeasure,targetMeasure : targetMeasure)
    
    //입력받은 단위가 유효한 값인지 체크, 단위중 한개라도 딕셔너리에 없으면 에러메세지 표시
    if let inputType = formula.checkType(inputMeasure: inputMeasure) , let targetType = formula.checkType(inputMeasure: targetMeasure) , inputType == targetType{
        let (inFormula,outFormula) = formula.returnFormularNumber(type: inputType, inMeasure: inputMeasure,outMeasure : targetMeasure)!
        print("\(multiplier(inputOne: inputNumber, inputTwo: inFormula, inputThree: outFormula))\(targetMeasure)")
    }
    else {
        print (returnErrorMessage())
    }
}

