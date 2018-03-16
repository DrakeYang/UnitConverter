//
//  main.swift
//  unitConverter
//
//  Created by Yoda Codd on 2018. 3. 5..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation


// 에러메세지 출력 함수
func returnErrorMessage(){
    print ("지원하지 않는 단위입니다.")
    return runApp()
}

// 계산용 공식을 저장하는 구조체
//구체적인 공식내용은 딕셔너리로 정리
struct FormulaSet{
    // 계산용 공식객체 선언
    let calculater = inputCalculater()
    
    // 공식을 저장하는 dictionary
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
        else {
            return nil
        }
    }
    
    // 입력단위,타겟단위 닐체크 하고 둘의 종류가 같다면 종류 리턴
    func measureType( inputMeasure : String , targetMeasure : String) -> (String)?{
        if let inputType = checkType(inputMeasure: inputMeasure) , let targetType = checkType(inputMeasure: targetMeasure) , inputType == targetType{
            return (inputType)
        }
        else {
            return nil
        }
    }
    
    // 입력단위,변환단위,단위타입을 입력받아서 곱셈용 공식 리턴
    func formulaFromMeasures(inputMeasure : String,targetMeasure : String, type : String ) -> Double?{
        if let (inFormula,outFormula) = returnFormularNumber(type: type, inMeasure: inputMeasure,outMeasure : targetMeasure){
            return (calculater.multiplier(multipleOne: inFormula, multipleTwo: outFormula))
        } else {
            return nil
        }
    }
}

//유저의 입력값을 받아서 리턴.
struct inputGetter {
    //유저 입력을 받는 함수
    func recieveUserInput()->String {
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
        let letters =  recieveUserInput()
        if checkQuit(letters: letters) {
            return letters
        }
        else {
            return nil
        }
    }
}

// 입력받은 문자열을 나눠주는 객체
struct inputDivider{
    //공백을 기준으로 문자열을 나누어서 리턴하는 함수. 공백이 없으면 두번째 리턴값은 ""
    func divideBySpace(letters : String) -> (String, String){
        let arry = letters.components(separatedBy: " ")
        if arry.count == 1 {
            return (letters,"")
        } else {
            return (arry[0],arry[1])
        }
    }
    
    // 문자열을 입력받아 숫자와 . 갯수를 더해서 리턴
    func numberOfNumberDot(letters : String) -> Int{
        var numberOfNumber = letters.components(separatedBy: CharacterSet.decimalDigits.inverted).joined().count
        // . 이 있으면 넘버 숫자에  +1
        if letters.contains("."){
            numberOfNumber += 1
        }
        return numberOfNumber
    }
    
    // 문자열과 숫자를 입력받아 처음~숫자개수 까지의 String을 리턴하는 함수
    func betweenBeginAndIndex(letters : String, numberOfLetter : Int) -> Range<String.Index>{
        // 입력받은 문자열에서 처음~숫자개수 까지의 인덱스 생성
        return letters.startIndex..<letters.index(letters.startIndex,offsetBy: numberOfLetter)
    }
    // 문자열과 숫자를 입력받아 숫자개수~끝 까지의 String을 리턴하는 함수
    func betweenIndexAndEnd(letters : String, numberOfLetter : Int) -> Range<String.Index>{
        // 입력받은 문자열에서 숫자개수~끝 까지의 인덱스 생성
        return  letters.index(letters.startIndex,offsetBy: numberOfLetter)..<letters.endIndex
    }
    
    // 문자열과 범위를 받아서 범위만큼 리턴하는 함수
    func substringLetters(letters : String, rangeIndex : Range<String.Index>) -> String {
        return String(letters[rangeIndex])
    }
    
    // 입력받은 문자열을 3개로 나누는 함수. 2개 함수를 둘다 부른다.
    func divideUserInput(letters : String)->(String,String,String){
        // 입력받은 문자열에서 공백을 기준으로 타겟단위를 분리
        let (numberWithMeasure,targetMeasure) = divideBySpace(letters: letters)
        
        // 입력받은 문자열의 숫자갯수
        let numberOfNumber = numberOfNumberDot(letters: numberWithMeasure)
        //숫자와 문자 범위인덱스 생성
        let numberRange = betweenBeginAndIndex(letters: numberWithMeasure, numberOfLetter: numberOfNumber)
        let inputMeasureRange = betweenIndexAndEnd(letters: numberWithMeasure, numberOfLetter: numberOfNumber)
        
        // 범위인덱스로 문자열 분리
        let number = substringLetters(letters: numberWithMeasure, rangeIndex: numberRange)
        let inputMeasure = substringLetters(letters: numberWithMeasure, rangeIndex: inputMeasureRange)
        // 분리된 변수들을 리턴
        return (number,inputMeasure,targetMeasure)
    }
}

// 유저 입력값을 받아서 검증하고 계산용으로 리턴하는 객체
struct inputChecker {
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
    // 입력받은 문자열에 대한 검사를 모아놓은 함수
    func checkingLetters(number : String, inputMeasure : String, targetMeasure : String) -> (Double,String,String)?{
        let checkedTargetMeasure = fillEmptyTargetMeasure(inputMeasure: inputMeasure, targetMeasure: targetMeasure)
        if let checkedNumber = lettersToNumber(letters: number){
            return (checkedNumber,inputMeasure,checkedTargetMeasure)
        }else {
            return nil
        }
    }
}


// 구체적인 계산에 쓰는 함수들이 모인 객체.
struct inputCalculater {
    // 숫자 셋을 입력받아 곱셈하는 함수
    func multiplier(multipleOne : Double ,multipleTwo : Double, multipleThree : Double) -> Double{
        return (multipleOne * multipleTwo * multipleThree)
    }
    // 숫자 둘을 입력받아 곱셈하는 함수
    func multiplier(multipleOne : Double ,multipleTwo : Double) -> Double{
        return (multipleOne * multipleTwo )
    }
    // 입력값,공식을 곱해서 타겟단위 붙여서 출력 후 runApp 실행해주는 함수
    func printAndRerun(inputNumber: Double, inputFormula : Double, targetMeasure : String) {
        print("\(multiplier(multipleOne: inputNumber, multipleTwo: inputFormula))\(targetMeasure)")
        return runApp()
    }
}

//  메인 함수
func runApp(){
    // 구조체 선언
    let formula = FormulaSet()
    let getter = inputGetter()
    let divider = inputDivider()
    let checker = inputChecker()
    let calculater = inputCalculater()
    
    //유저가 데이터 입력
    guard let userInput = getter.checkQuitOrNot() else {
        return ()
    }
    
    // 위의 함수로 변환한 값을 각각의 변수에 입력
    var (inputSize , inputMeasure , targetMeasure) = divider.divideUserInput(letters: userInput)
    
    // 숫자부분을 받을 변수 선언
    var inputNumber : Double = 0
    // 변수 체크
    
    guard (inputNumber , inputMeasure , targetMeasure) = checker.checkingLetters(number: inputSize, inputMeasure: inputMeasure, targetMeasure: targetMeasure )else {
        returnErrorMessage()
    }
    
   
    // 단위 종류를 저장
    guard let measureType = formula.measureType(inputMeasure: inputMeasure, targetMeasure: targetMeasure) else {
        return returnErrorMessage()
    }
    
    // 단위 변환용 수식을 저장
    guard let multiplyFormula = formula.formulaFromMeasures(inputMeasure: inputMeasure, targetMeasure: targetMeasure, type: measureType) else {
        return returnErrorMessage()
    }
    
    // 단위 변환용 수식을 입력받은 수에 대입하여 출력
    printAndRerun(inputNumber: inputNumber, inputFormula: multiplyFormula, targetMeasure: targetMeasure)
}
runApp()







