//
//  CardCollectionViewCell.swift
//  Card Game
//
//  Created by 안현정 on 2021/10/05.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var frontImageView: UIImageView!
    
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?

    //셀에 전달되는 카드가 디스플레이에 나타내기를 원하는 카드
    func setCard(_ card:Card) {
        
        
        // 카드를 추적하여 다음 작업 수행
        self.card = card
        
        //카드가 일치하는 경우 이미지뷰 불투명도 0으로 보이지않게 설정
        //이렇게 해주지않으면, 스크롤해서 다시 위로 올렸을 때, 일치시켜 없앴던 카드가 다시 화면에 나타남
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        }
        else {
            
            //카드가 일치하지 않으면 이미지를 볼 수 있게 설정 
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        //전면 이미지보기
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        }
    }
    
    //후면 이미지 보기에서 전면 이미지 보기로 뒤집기
    func flip() {
        
        //애니메이션
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    //전면에서 후면 이미지보기로 뒤집기
    func flipBack() {
        
        //지연 매개변수
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            //애니메이션
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
  
    }
    
    
    func remove() {
        
        //뒤집은 두 이미지가 표시되지않도록 제거
        //TODO: Animate it
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            //불투명도가 0으로 설정되어 두 이미지가 보이지않게 된다.
        } , completion: nil)
            
        }
    
       
    
    }


 
