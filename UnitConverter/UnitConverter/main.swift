//
//  main.swift
//  unitConverter
//
//  Created by Yoda Codd on 2018. 3. 5..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation

// 계산용 공식을 저장하는 구조체
//구체적인 공식내용은 딕셔너리로 정리
struct FormulaSet{
    // 공식을 저장하는 dictionary
    let formula = ["length" : ["inWorking" :["m":100.0,"cm":1.0,"yard":91.44,"inch":2.54]
                            , "outWorking" : ["m":0.01,"cm":1.0,"yard":0.01,"inch":0.39]]
                ,"weight" : ["inWorking" : ["kg":1.0,"oz":35.27,"lb":0.45]
                            , "outWorking" : ["kg":1.0,"oz":0.02,"lb":2.2]]]
    
    // 단위의 타입을 리턴하는 함수
    func typeHas(inputMeasure : String) -> String?  {
        for type in formula.keys{
            if formula[type]?["inWorking"]?[inputMeasure] != nil {
                return type
            }
        }
        return nil
    }
    // 타입과 입력단위,목표단위를
    func formularNumberFrom(type : String, inMeasure : String,outMeasure : String) -> (inFormula : Double,outFormula : Double)?{
        if let inFormula = formula[type]?["inWorking"]?[inMeasure] ,let outFormula = formula[type]?["outWorking"]?[outMeasure] {
            return (inFormula,outFormula)
        }
        else {
            return nil
        }
    }
    
    // 입력단위,타겟단위 닐체크 하고 둘의 종류가 같다면 종류 리턴
    func measureTypeFrom( inputMeasure : String , targetMeasure : String) -> (String)?{
        if let inputType = typeHas(inputMeasure: inputMeasure) , let targetType = typeHas(inputMeasure: targetMeasure) , inputType == targetType{
            return (inputType)
        }
        else {
            return nil
        }
    }
    // 입력단위와 타겟단위를 입력받으면 곱셈용 공식 둘을 곱해서 리턴
    func totalFormulaFrom(inputMeasure : String,targetMeasure : String) -> Double?{
        guard let checkedmeasureTypeFrom = measureTypeFrom(inputMeasure:inputMeasure,targetMeasure:targetMeasure) else {
            return nil
        }
        if let (inFormula,outFormula) = formularNumberFrom(type: checkedmeasureTypeFrom, inMeasure: inputMeasure,outMeasure : targetMeasure){
            return (CalCulater.multiplier(multipleOne: inFormula, multipleTwo: outFormula))
        } else {
            return nil
        }
    }
}

//유저의 입력값을 받아서 리턴.
struct InputGetter {
    //유저 입력을 받는 함수
    func userInputReciever()->String {
        //유저 입력을 받기 위해 입력을 요청
        print("Please enter size : ", terminator: "")
        //유저 입력을 받아서 userInput 에 입력
        if let userInput = readLine(){
            return userInput
        }
        else {
            return ""
        }
    }
    
    //입력받은 문자열이 q or quit 일 경우 false 리턴
    func checkQuit(letters : String) -> Bool {
        if letters == "q" || letters == "quit" {
            return true
        } else {
            return false
        }
    }
    
    //입력을 받아서 종료구문인지 체크 후 입력이나 종료 리턴
    func checkQuitOrNot() -> String?{
        //유저 입력을 받는다
        let letters =  userInputReciever()
        // 유저 입력이 q or quit 이면
        if checkQuit(letters: letters) {
            return nil
        }
        else {
            return letters
        }
    }
}

// 입력받은 문자열을 나눠주는 객체
struct InputDivider{
    //공백을 기준으로 문자열을 나누어서 리턴하는 함수. 공백이 없으면 두번째 리턴값은 ""
    func dividedArrayFrom(letters : String) -> (frontLaters : String, behindLetters : String){
        let arry = letters.components(separatedBy: " ")
        if arry.count == 1 {
            return (letters,"")
        } else {
            return (arry[0],arry[1])
        }
    }
    
    // 문자열을 입력받아 숫자와 . 갯수를 더해서 리턴
    func dotsNumberFrom(letters : String) -> Int{
        var numberOfNumber = letters.components(separatedBy: CharacterSet.decimalDigits.inverted).joined().count
        // . 이 있으면 넘버 숫자에  +1
        if letters.contains("."){
            numberOfNumber += 1
        }
        return numberOfNumber
    }
    
    // 문자열과 숫자를 입력받아 처음~숫자개수 까지의 String을 리턴하는 함수
    func betweenBeginAndPoint(letters : String, numberOfLetter : Int) -> Range<String.Index>{
        // 입력받은 문자열에서 처음~숫자개수 까지의 인덱스 생성
        return letters.startIndex..<letters.index(letters.startIndex,offsetBy: numberOfLetter)
    }
    // 문자열과 숫자를 입력받아 숫자개수~끝 까지의 String을 리턴하는 함수
    func betweenPointAndEnd(letters : String, numberOfLetter : Int) -> Range<String.Index>{
        // 입력받은 문자열에서 숫자개수~끝 까지의 인덱스 생성
        return  letters.index(letters.startIndex,offsetBy: numberOfLetter)..<letters.endIndex
    }
    
    // 문자열과 범위를 받아서 범위만큼 리턴하는 함수
    func substringLettersFrom(letters : String, rangeIndex : Range<String.Index>) -> String {
        return String(letters[rangeIndex])
    }
    
    // 입력받은 문자열을 3개로 나누는 함수. 2개 함수를 둘다 부른다.
    func dividedThreeFrom(letters : String)->(number : String,secondLetters : String, thirdLetters : String){
        // 입력받은 문자열에서 공백을 기준으로 타겟단위를 분리
        let (numberWithMeasure,targetMeasure) = dividedArrayFrom(letters: letters)
        
        // 입력받은 문자열의 숫자갯수
        let numberOfNumber = dotsNumberFrom(letters: numberWithMeasure)
        //숫자와 문자 범위인덱스 생성
        let numberRange = betweenBeginAndPoint(letters: numberWithMeasure, numberOfLetter: numberOfNumber)
        let inputMeasureRange = betweenPointAndEnd(letters: numberWithMeasure, numberOfLetter: numberOfNumber)
        
        // 범위인덱스로 문자열 분리
        let number = substringLettersFrom(letters: numberWithMeasure, rangeIndex: numberRange)
        let inputMeasure = substringLettersFrom(letters: numberWithMeasure, rangeIndex: inputMeasureRange)
        // 분리된 변수들을 리턴
        return (number,inputMeasure,targetMeasure)
    }
}

// 유저 입력값을 받아서 검증하고 계산용으로 리턴하는 객체
struct InputChecker {
    //변환할 단위가 없는경우를 위한 함수
    func fillEmpty(inputMeasure : String, targetMeasure : String)-> String {
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
    func numberFrom(letters : String) -> Double? {
        if let number = Double(letters){
            return number
        }
        else {
            print("잘못된 숫자입니다")
            return nil
        }
    }
    // 입력받은 문자열에 대한 검사를 모아놓은 함수
    func verifiedNumberAndTarget(number : String, inputMeasure : String, targetMeasure : String) -> (checkedNumber : Double,checkedTargetMeasure : String)?{
        let checkedTargetMeasure = fillEmpty(inputMeasure: inputMeasure, targetMeasure: targetMeasure)
        if let checkedNumber = numberFrom(letters: number){
            return (checkedNumber,checkedTargetMeasure)
        }else {
            return nil
        }
    }
}


// 구체적인 계산에 쓰는 함수들이 모인 객체.
struct CalCulater {
    // 숫자 셋을 입력받아 곱셈하는 함수
    static func multiplier(multipleOne : Double ,multipleTwo : Double, multipleThree : Double) -> Double{
        return (multipleOne * multipleTwo * multipleThree)
    }
    // 숫자 둘을 입력받아 곱셈하는 함수
    static func multiplier(multipleOne : Double ,multipleTwo : Double) -> Double{
        return (multipleOne * multipleTwo )
    }
    
}

// 출력 함수들이 모인 객체
struct MessagePrint {
    // 입력값,공식을 곱해서 타겟단위 붙여서 출력 후 runApp 실행해주는 함수
    static func printCalculation(inputNumber: Double, formula : Double, targetMeasure : String) {
        print("\(CalCulater.multiplier(multipleOne: inputNumber, multipleTwo: formula))\(targetMeasure)")
    }
    
    // 에러메세지 출력 함수
    static func printErrorMessage(){
        print ("지원하지 않는 단위입니다.")
    }
}

//  메인 함수
func runApp(){
    // 구조체 선언
    let formula = FormulaSet()
    let getter = InputGetter()
    let divider = InputDivider()
    let checker = InputChecker()
    
    while true {
        //유저가 데이터 입력
        guard let userInput = getter.checkQuitOrNot() else {
            break
        }
        
        // 위의 함수로 변환한 값을 각각의 변수에 입력
        let (inputSize , inputMeasure , targetMeasure) = divider.dividedThreeFrom(letters: userInput)
        
        // 입력받은 숫자를 double 형태로 리턴하고, 타겟단위가 없는 경우 타겟리턴값을 리턴
        guard let (inputNumber,checkedTargetMeasure) = checker.verifiedNumberAndTarget(number: inputSize, inputMeasure: inputMeasure, targetMeasure: targetMeasure ) else {
            MessagePrint.printErrorMessage()
            continue
        }
        
        // 곱셈용 공식을 저장
        guard let multiplyFormula = formula.totalFormulaFrom(inputMeasure: inputMeasure, targetMeasure: checkedTargetMeasure) else {
            MessagePrint.printErrorMessage()
            continue
        }
        
        // 단위 변환용 수식을 입력받은 수에 대입하여 출력
        MessagePrint.printCalculation(inputNumber: inputNumber, formula: multiplyFormula, targetMeasure: checkedTargetMeasure)
        //  전체 프로세스 진행 후 다시 앱 실행
        
    }
}
runApp()







