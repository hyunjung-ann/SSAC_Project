//
//  CatagoryViewController.swift
//  NANA
//
//  Created by 안현정 on 2021/09/29.
//

import UIKit

class CatagoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white //backbutton 색 커스텀
        self.navigationController?.navigationBar.topItem?.title = "" //backbutton 텍스트 없애기

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
