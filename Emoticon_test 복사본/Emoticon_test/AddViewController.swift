 //
//  AddViewController.swift
//  Emoticon_test
//
//  Created by 안현정 on 2021/09/17.
//

import UIKit


class AddViewController: UIViewController {

    
    //저장버튼
    @IBAction func AddButton(_ sender: Any) {
        //텍스트 필드에 입력되있는 텍스트를 상수에 저장
        let emoticon = emoticonTextField.text
        
        //새로운 이모티콘 인스턴스를 생성 -> 배열에 저장
        //위 입력되있던 텍스트를 가져와서 새로운 이모티콘을 생성한 다음 배열에 저장
        let newEmoticon = Emoticon(content: emoticon ?? "")
        Emoticon.dummyEmoticonList.append(newEmoticon)
        
        dismiss(animated: true, completion: nil)
    }
    
    //취소버튼
    @IBAction func Close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var emoticonTextField: UITextField!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
