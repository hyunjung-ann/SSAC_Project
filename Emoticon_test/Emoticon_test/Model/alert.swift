//
//  alert.swift
//  Emoticon_test
//
//  Created by 안현정 on 2021/09/22.
//

import Foundation

import UIKit


// UIViewController를 상속하는 모든 class에서 이용가능하도록 extension 사용
extension UIViewController {
    // 경고창 표시
    func alert (title: String = "Notice", message: String) {
        // alert view
        let alert = UIAlertController(title: title, message: "정말 닫으시겠습니까?", preferredStyle: .alert)
        // 경고창에 표시되는 버튼
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil )// 버튼 누르고 실행할 코드
        alert.addAction(okAction)
        // 경고창을 화면에 표시
        present(alert, animated: true, completion: nil)
        
    }
}
