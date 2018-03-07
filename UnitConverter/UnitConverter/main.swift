//
//  main.swift
//  unitConverter
//
//  Created by Yoda Codd on 2018. 3. 5..
//  Copyright © 2018년 Drake. All rights reserved.
//

import Foundation
// 계속 쓰이는 단위 100 을 상수로 지정
let measureCmToMeter : Double = 100
// inch to cm 단위 저장
let measureInchToCm : Double = 2.54
// cm to yard 단위 저장
let measureYardToCm : Double = 91.44
// oz to g 단위 저장
let measureOzToG : Double = 28.34
// lb to g 단위 저장
let measureLbToG : Double = 453.59

//반복을 위한 while 변수 설정
var stopSwitch : Int = 0
//반복문 시작
while stopSwitch == 0 {
    
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
    if userInput == "q" || userInput == "quit" {
        stopSwitch += 1
        break
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
    // 위의 함수로 변환한 값을 각각의 변수에 입력
    let (inputSize , inputMeasure , targetMeasure) = divideUserinput(tempInput : userInput)
    
    //숫자만 자른 숫자 string 을 더블타입으로 변환. 아무값 없다면 0으로 치환됨
    let inputNumber = (inputSize as NSString).doubleValue
    
    //cm 을 m 로 바꿔서 출력하는 함수
    func cmToMeter(cmNumber : Double) -> Double{
        return (cmNumber / measureCmToMeter)
    }
    //m 를 cm 으로 바꿔서 출력하는 함수
    func meterToCm(meterNumber : Double) -> Double{
        return (meterNumber * measureCmToMeter)
    }
    // cm 을 inch 로 바꿔서 출력하는 함수
    func cmToInch(cmNumber : Double) -> Double{
        return (cmNumber / measureInchToCm)
    }
    // inch to cm 함수
    func inchToCm(inchNumber : Double) -> Double{
        return (inchNumber * measureInchToCm )
    }
    // cm to yard 함수
    func cmToYard(cmNumber : Double) -> Double{
        return cmNumber / measureYardToCm
    }
    //yard to cm 함수
    func yardToCm(yardNumber : Double) -> Double{
        return yardNumber * measureYardToCm
    }
    // oz to g 함수
    func ozToG(ozNumber : Double) -> Double {
        return ozNumber * measureOzToG
    }
    // g to oz 함수
    func gToOz(gNumber : Double) -> Double {
        return gNumber / measureOzToG
    }
    // lb to g 함수
    func lbToG(lbNumber : Double) -> Double {
        return lbNumber * measureLbToG
    }
    // g to lb 함수
    func gToLb(gNumber : Double) -> Double {
        return gNumber / measureLbToG
    }
    
    
    //변환할 단위가 없을 경우 사용하는 함수
    func measureTransformNoTarget(measure : String) -> String {
        switch measure{
        //cm 이면 100 으로 나누고 m 을 붙여서 리턴
        case "cm" :
            return ("\(cmToMeter(cmNumber : inputNumber))m")
        // m 이면 100을 곱해주고 cm을 붙여서 리턴
        case "m" :
            return ("\(Int(meterToCm(meterNumber : inputNumber)))cm")
        // yard 의 경우 yard to cm , cm to m 진행
        case "yard" :
            //return ("\((cmToMeter(cmNumber : yardToCm(yardNumber : inputNumber))))m")
            return ("\((cmToMeter(cmNumber : yardToCm(yardNumber : inputNumber))))m")
        // 주어진 값 이외의 값이면 잘못된 단위 라는 메세지 출력
        default : return("지원하지 않는 단위입니다.")
        }
    }
    //변환할 단위가 있는 경우를 위한 함수
    //함수의 인자 : 입력받은 수치, 원래 단위, 변환할 단위
    func measureTransformWithTarget(oringSize : Double , originMeasure : String, toMeasure : String) -> String{
        // 출력할 수치용 변수 선언
        var transformedSize : Double = oringSize
        switch targetMeasure{
        // 목표단위가 inch 인 경우
        case "inch" :
            // 원래단위가 m 인 경우 cm 로 변경해준다
            if inputMeasure == "m" {
                transformedSize = meterToCm(meterNumber : transformedSize)
            }
            else if inputMeasure == "yard"{
                transformedSize = yardToCm(yardNumber : transformedSize)
            }
            // inch 로 변환시킨후 inch 글자 붙여서 리턴
            return ("\(cmToInch(cmNumber : transformedSize))inch")
            
        // 변환 단위가 cm 인 경우
        case  "cm" :
            //inch to cm 변환 후 리턴
            if inputMeasure == "m" {
                return ("\(Int(inchToCm(inchNumber : transformedSize)))cm")
            }
            else if inputMeasure == "yard"{
                return ("\(yardToCm(yardNumber : transformedSize))cm")
            }
            
        // 변환 단위가 m 인 경우
        case "m" :
            // 입력단위가 inch 인 경우 inch to cm 변환 후 다시 cm to m 변환 후 리턴
            if inputMeasure == "inch" {
                return ("\(cmToMeter(cmNumber : (inchToCm(inchNumber : transformedSize))))m")
            }
                // 입력단위가 yard 인 경우
            else if inputMeasure == "yard"{
                return ("\(cmToMeter(cmNumber : yardToCm(yardNumber : transformedSize)))m")
            }
        // 변환단위가 g 인 경우
        case "g" :
            if inputMeasure == "oz" {
                return ("\(ozToG(ozNumber : transformedSize))g")
            }
            else if inputMeasure == "lb" {
                return ("\(lbToG(lbNumber : transformedSize))g")
            }
        //변환단위가 oz 인 경우
        case "oz" :
            return ("\(gToOz(gNumber : transformedSize))oz")
        //변환단위가 lb 인 경우
        case "lb" :
            return ("\(gToLb(gNumber : transformedSize))lb")
        // 이외의 값이라면 에러메세지 출력
        default :
            return ("지원하지 않는 단위 입니다.")
        }
        return ("지원하지 않는 단위 입니다.")
    }
    
    //변환 출력 함수 실행 함수
    func printResult() {
        // 변환단위가 없으면 단위 없는 변환함수 사용
        if targetMeasure == "" {
            print(measureTransformNoTarget(measure: inputMeasure))
        }
            // 변환단위가 있으면 단위 있는 변환함수 사용
        else {
            print(measureTransformWithTarget(oringSize: inputNumber, originMeasure: inputMeasure, toMeasure: targetMeasure))
        }
        
    }
    //출력 실행
    printResult()
}

