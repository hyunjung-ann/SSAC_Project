//
//  FirstViewController.swift
//  Emoticon_test
//
//  Created by 안현정 on 2021/09/21.
//

import UIKit
import CoreData


class FirstViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,SendDataDelegate  {
    func sendData(data: Emoticon) {
        emoticonList = self
    }
    

    
    @IBOutlet weak var tableView: UITableView!
    
//UITableViewDelegate : 테이블 뷰를 어떻게 보여줄 것인가 ?
//UITableViewDataSource : 테이블 뷰의 셀은 총 몇 개? -> 두개의 프로토콜 최상단 추가
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
             tableView.delegate = self
             tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
 


    
    // MARK: - TableViewDataSource

    //행을 구성하는 셀을 반환
    //하나의 재활용 가능한 셀(Resuable cell)을 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        //dequeReusableCell은 재활용 가능한 셀을 큐(queue)의 형태로 추가/제거
        //for : 셀의 위치를 ​​지정하는 색인 ​​경로, 항상 데이터 원본 개체에서 제공하는 인덱스 경로를 지정
        //cell: 아까 추가한 테이블 뷰 셀의 구분자(identifier)를 적는 곳 / 이 구분자를 통해 셀을 가져오고 그 셀을 재활용
        
        let target = Emoticon.dummyEmoticonList[indexPath.row]
        cell.textLabel?.text = target.content
        
        return cell
    }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Emoticon.dummyEmoticonList.count
      }
    
    
// MARK: - METHOD
    
    /// 버튼을 클릭하면 호출되는 메소드
    
    // SecondViewController를 화면에 띄운다.
    
    // 1. UIViewController 인스턴스를 생성한다.
    // 옵셔널 바인딩
  /* @IBAction func buttonDidTapped(_ sender: UIButton) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "myCell") as! AddViewController
    vc.delegate = self
    vc.modalPresentationStyle = .fullScreen

    }
    
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

     */
}
