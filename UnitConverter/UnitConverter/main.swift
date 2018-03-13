//
//  main.swift
//  unitConverter
//
//  Created by Yoda Codd on 2018. 3. 5..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation

// 숫자 셋을 입력받아 곱셈하는 함수
func multiplier(multipleOne : Double ,multipleTwo : Double, multipleThree : Double) -> Double{
    return (multipleOne * multipleTwo * multipleThree)
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

//공백을 기준으로 문자열을 나누어서 리턴하는 함수. 공백이 없으면 두번째 리턴값은 ""
func divideBySpace(letters : String) -> (String, String){
    let arry = letters.components(separatedBy: " ")
    if arry.count == 1 {
        return (letters,"")
    } else {
        return (arry[0],arry[1])
    }
}

// 문자열을 입력받아 숫자와 . 으로 이루어진 문자열, 나머지 문자열 둘로 나누어서 리턴
func numericOrElse(letters : String)->(String,String){
    // 입력받은 문자열의 숫자갯수
    var numberOfNumber = letters.components(separatedBy: CharacterSet.decimalDigits.inverted).joined().count
    // . 이 있으면 넘버 숫자에  +1
    if letters.contains("."){
        numberOfNumber += 1
    }
    //숫자가 끝나는 인덱스로 범위 생성
    let numberRange = letters.startIndex..<letters.index(letters.startIndex,offsetBy: numberOfNumber)
    let measureRange = letters.index(letters.startIndex,offsetBy: numberOfNumber)..<letters.endIndex
    //범위로 대입
    let number = String(letters[numberRange])
    let inputMeasure = String(letters[measureRange])
    
    return (number,inputMeasure)
}
// 입력받은 문자열을 3개로 나누는 함수. 2개 함수를 둘다 부른다.
func divideUserInput(userInput : String)->(String,String,String){
    // 입력받은 문자열에서 공백을 기준으로 타겟단위를 분리
    let (numberWithMeasure,targetMeasure) = divideBySpace(letters: userInput)
    // 숫자와 단위 를 서로 분리
    let (number,inputMeasure) = numericOrElse(letters: numberWithMeasure)
    // 분리된 변수들을 리턴
    return (number,inputMeasure,targetMeasure)
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

//문자열을 더블로 바꿔 리턴해주는 함수. 바꾸기 실패할 경우 nil 리턴
func lettersToNumber(letters : String) -> Double? {
    if let number = Double(letters){
        return number
    }
    else {
        print("잘못된 숫자입니다")
        return nil
    }
}

//  입력받은
func runApp(){
    //반복문 시작
   
    //유저가 데이터 입력
    let userInput : String = recieveUserInput()
    if userInput == "q" || userInput == "quit" {
        return ()
    }
    
    // 위의 함수로 변환한 값을 각각의 변수에 입력
    var (inputSize , inputMeasure , targetMeasure) = divideUserInput(userInput : userInput)
    // 입력받은 문자열 숫자를 더블로 받아줄 변수
    var inputNumber : Double = 0
    
    // 구조체 선언
    let formula = FormulaSet()
    
    
    //숫자만 자른 숫자 string 을 더블타입으로 변환.
    if let doubleNumber = lettersToNumber(letters: inputSize){
        inputNumber = doubleNumber
    } else {
        return runApp()
    }
    
    //targetMeasure 가 비어있을 경우를 위해서 함수 실행.
    targetMeasure = fillEmptyTargetMeasure(inputMeasure : inputMeasure,targetMeasure : targetMeasure)
    
    //입력받은 단위가 유효한 값인지 체크, 단위중 한개라도 딕셔너리에 없으면 에러메세지 표시
    if let inputType = formula.checkType(inputMeasure: inputMeasure) , let targetType = formula.checkType(inputMeasure: targetMeasure) , inputType == targetType{
        let (inFormula,outFormula) = formula.returnFormularNumber(type: inputType, inMeasure: inputMeasure,outMeasure : targetMeasure)!
        print("\(multiplier(multipleOne: inputNumber, multipleTwo: inFormula, multipleThree: outFormula))\(targetMeasure)")
        return runApp()
    }
    else {
        print (returnErrorMessage())
        return runApp()
    }
    
}
runApp()
