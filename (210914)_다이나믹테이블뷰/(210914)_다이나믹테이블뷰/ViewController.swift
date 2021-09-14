//
//  ViewController.swift
//  (210914)_다이나믹테이블뷰
//
//  Created by 안현정 on 2021/09/14.
//

import UIKit

class ViewController: UIViewController {

// UITableViewDelegate: 테이블뷰에 대한 설정
// UITableViewDataSource : Ui테이블 표 데이터 소스 집어넣는 것
    
    @IBOutlet weak var myTableView: UITableView!
    
    let contentArray = [
        "st so. Everybody knows that when it is noon in the Unite States the sun is setting over France.",
        
        "If you could fly to France in one minute, you could go straight into the sunset, right from noon. Unfortunately, France is too far away for that. ",
        
        "One day you said to me, I saw the sunset forty-four times!",
        
        "On the fifth day-- again, as always, it was thanks to the sheep-- the secret of the little prince's "
        
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 셀 리소스 파일 가져오기
       // let myTableViewCellNib = UINib(nibName: "MyTableViewCell", bundle: <#T##Bundle?#>)
        let myTableViewCellNib = UINib(nibName: String(describing: MyTalbeViewCell.self), bundle: nil)
        
        
        //셀에 가져온 리소스 등록
        //현재 뷰컨트롤러가 가지고있는 mytableview에 register -> nib파일
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: "myTalbeViewCell")
        
        //셀의 높이 - 자동으로 계산
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 120 //예상 높이
        
        //아주 중요!!! 이걸 해줘야 서로 연결이 됨
        self.myTableView.delegate = self //delegate은 나 자신
        self.myTableView.dataSource = self //데이터소스를 나 자신으로 연결
        
        print("contentArray.count : \(contentArray.count)")
    }

}

extension ViewController: UITableViewDelegate {
    // 위에 있는 ViewController class를 확장해서 쓴다 -> 위에 코드가 복잡해지니 나눈다고 생각하면 좋다

}

extension ViewController: UITableViewDataSource {

    //테이블 뷰 셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArray.count //데이터를 가지고있는 배열
    }
    
    //각 셀에 대한 설정 - 데이터랑 뷰를 연결
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myTalbeViewCell", for: indexPath) as! MyTalbeViewCell
        
        cell.userContentLabel.text = contentArray[indexPath.row]
        
        return cell
    }

}


