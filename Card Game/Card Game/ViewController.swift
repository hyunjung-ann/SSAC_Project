//
//  ViewController.swift
//  Card Game
//
//  Created by 안현정 on 2021/10/03.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
 

   

    
    
    var model = CardModel()
    var cardArray = [Card]() //카드 객체를 포함하는 빈배열
    
    
    var fistFlippedCardIndex: IndexPath?
    
    var timer: Timer?
    //사용자에게 얼마나 많은 시간을 주어야하는지 설정
    var milliseconds:Float = 60 * 1000 //10초

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //카드 가져오기 메서드
        cardArray = model.getCards()
        
        collectionView.delegate = self //컬렉션 뷰 대리자는 뷰컨트롤러
        collectionView.dataSource = self
        
        //create timer
        //매 밀리초마다 실행, 밀리초마다 timerElapsed 메서드 호출, 종료되면 반복
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        //사용자의 스크롤 여부와 상관없이 타이머 실행 루프
        RunLoop.main.add(timer!, forMode: .common)
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Timer Methods
    
    //타이머 실행될 때 마다 코드 실행
    @objc func timerElapsed() {
        
        milliseconds -= 1 //1과 같거나 적다
        
        // 초로 변환
        // 소수점 이하 두 자리가 있는 문자열 형식으로 지정
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        //label 설정
        let label = timerLabel
        label?.font = UIFont.boldSystemFont(ofSize: 16)
        timerLabel.text = "💣 Time : \(seconds)"
        
        //타이머가 0이 될 때
        if milliseconds <= 0 {
            
            //타이머 정지
            timer?.invalidate() //무효화 메서드를 통해 타이머 중지
            timerLabel.textColor = UIColor.red
            
            //일치되지 않은 카드가 있는지 확인
            checkGameEnded()
        }
        

    }
    

    //MARK:- UIColleciotnView Protocol Methods

    //표시해야하는 데이터항목 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get an CardCollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //collection view에서 보여주려는 카드를 가져오기
        let card = cardArray[indexPath.row]
        
        //해당 카드를 셀에 설정
        cell.setCard(card)
        
        return cell
    }

    
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    print("a cell is tapped : \(indexPath.row)")

    
    
    //남은 시간이 존재한다면
    if milliseconds <= 0 {
        return
    }
    
     
    let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
    
   let card = cardArray[indexPath.row]
    
    //카드를 뒤집고, 일치하지 않는 경우,
    if card.isFlipped == false && card.isMatched == false {
        
        //카드 뒤집고
        cell.flip()
        
        
        //play the flip sound
        SoundManager.playSound(.Flip)
            
        //카드의 상태를 설정
        card.isFlipped = true
        
        //첫번째 카드인지 아니면 두번째 카드가 뒤집혔는지 결정
        //Determine if it's the first card or second card that's flipped over
        if  fistFlippedCardIndex == nil {
            
            //뒤집힌 첫번째 카드가 nil이면
            //this is the first card being flipped
            fistFlippedCardIndex = indexPath
        }
        
        else {
            //this is the second card being flipped
            
            //todo: perform the matching logic
            checkForMatches(indexPath) //일치확인 기능
        }
        
    }
   
  } // End the didSelectItemAt method
    
     // MARK:- Game Logic Methods
    
    //두번째 카드인 경우에만 일치확인
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        
        //공개된 두 장의 카드를 위한 셀을 가져오는 것
        //collectionView에서 해당 인덱스 경로에 대한 셀을 가져오려고 한다.
        //fistFlippedCardIndex 옵셔널 (문제가 발생하면 nil을 할당)
        let cardOneCell = collectionView.cellForItem(at: fistFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        //공개된 두 장의 카드를 위한 셀을 가져오는 것
        let cardOne = cardArray[fistFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //두개의 카드 일치하는지 비교
        if cardOne.imageName == cardTwo.imageName {
            
            //It's a match
            
            //play sound
            SoundManager.playSound(.match)
            
            //set the statuses of the cards
            cardOne.isMatched = true //카드 1이 일치하는 경우 true
            cardTwo.isMatched = true
            
            //remove the cards from the grid
            //옵셔널 체이닝
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //일치하지 않는 카드가 남아있는지 확인
            //만약 뒤집은 두카드가 전체 그리드의 마지막 두장이라면 게임의 종료를 알려야하기 때문에
            checkGameEnded()
            
        }
        else { //일치하지 않으면
            
            //It's a match
            
            //play sound
            SoundManager.playSound(.nomatch)
            
            //set the status of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false 
            
            //Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        //만약 nil이면 컬렉션 뷰에 첫 번째 카드의 셀을 다시 로드
        if cardOneCell == nil {
            
            //지정된 인덱스에 있는 항목만 다시 로드
            collectionView.reloadItems(at: [fistFlippedCardIndex!])
        }
        
        // 첫번째 카드를 추적하는 속성 재설정
        //첫번째 뒤집은 카드 인덱스를 nil로 설정 -> 프로세스 반복 (처음부터 다시 시작)
        fistFlippedCardIndex = nil
    }
    
    func checkGameEnded() {
        
        // 일치하지않는 카드가 있는지 확인
        var isWon = true
        
        for card in cardArray {
            
            if card.isMatched == false { //일치하지 않은 카드가 하나라도 있다면
                isWon = false // 이용자는 이기지 않았음
                break
            }
        }
        
        
        // 경고 메시지
        var title = ""
        var message = ""
        
        
        // 그렇지 않은 경우, 사용자는 이기고, 타이머는 정지
        if isWon == true { //이용자가 이겼다면
            
            if milliseconds > 0 { //시간 초가 0초보다 더 크면
                timer?.invalidate() // 타이머 무효화
            }
            
            title = "축하합니다!"
            message = "포켓몬을 다 획득했습니다"
            
        } else {
        // 일치되지않는 카드가 있다면, 남은 시간이 있는 지 확인
            
            if milliseconds > 0 {
                return
            }
            
            title = "Game Over"
            message = "포켓몬 획득에 실패했습니다"
        }
            
        // 승패 메시지 표시
        showAlert(title, message)
     
    }
    
    func showAlert(_ title:String, _ message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //경고해제 버튼
        let alertAction = UIAlertAction(title: "네", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
} //End Viewcontroller class

