//
//  CardModel.swift
//  Card Game
//
//  Created by 안현정 on 2021/10/03.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] { //각 카드객체는 해당카드와 연결된 데이터를 갖게 된다.
        
        
        //만들어둔 숫자를 저장하기 위한 배열 선언
        var generatedNumberArray = [Int]()
        
        //랜덤한 카드 쌍 만들기
        var generatedCardsArray = [Card]()
        
        while generatedNumberArray.count < 8 {
            
            //get a random number
            //(0)+1 로 설정하여 카드를 무작위로 가져오게 설정
            let randomNumber =  arc4random_uniform(11) + 1
        
            
            //randomNumber가 우리가 이미 가진 숫자인지 아닌지 확인
            if generatedNumberArray.contains(Int(randomNumber)) == false {
                
                //숫자 기록
                print(randomNumber)
                
                //generatedNumberArray에 숫자 저장
                generatedNumberArray.append(Int(randomNumber))
                
                //첫번째 카드 객체 생성
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardOne)
                
                //두번째 카드 객체 생성
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardTwo)
                
                
            }
            
        }
        
        
        // TODO: 카드 섞기
        for i in 0...generatedCardsArray.count-1 {
            
        // swap할 임의의 인덱스 찾음
        let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
        
        //swap the two cards
        let temporaryStorage = generatedCardsArray[0]
        generatedCardsArray[0] = generatedCardsArray[randomNumber]
        generatedCardsArray[randomNumber] = temporaryStorage
        
        }
        
  
        //return the array
        return generatedCardsArray
        
        
         
    }
    
}
