 //
//  AddViewController.swift
//  Emoticon_test
//
//  Created by 안현정 on 2021/09/17.
//

import UIKit
 
 //이모티콘 create하는 뷰에서 (이모티콘)데이터를 전달하는 함수를 포함하는 protocol 생성
 protocol SendDataDelegate {
    func sendData(data: Emoticon)

 }

class AddViewController: UIViewController {
    
    var delegate: SendDataDelegate? //프로토콜 변수
    var emoticonList: Emoticon?
    var flag = 0

    @IBOutlet weak var emoticonTextField: UITextField!
    
   override func viewDidLoad() {
       super.viewDidLoad()

       // Do any additional setup after loading the view.
   }
    
    

    //저장버튼
    
    @IBAction func Save(_ sender: UIBarButtonItem) {
    
    }
    
    //취소버튼
    @IBAction func Close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
