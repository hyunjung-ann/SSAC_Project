//
//  MyTableViewCell.swift
//  (210914)_다이나믹테이블뷰
//
//  Created by 안현정 on 2021/09/15.
//

import Foundation
import UIKit

class MyTalbeViewCell: UITableViewCell {
    
    //테이블뷰 셀 이미지에 접근 가능
    @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var userContentLabel: UILabel!
    
    // 셀이 렌더링(화면에 그릴 때) 될 때 (xib를 nib이라고함) -> 아래 호출되기 때문에 ui 커스텀 작업 할 수 있음
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("MyTableViewCell - awakeFromNib() called ")
        
        //유저 프로필 이미지 레이어 접근한다음 모서리를 둥글게 = 값을 해당하는 이미지 프레임의 높이 1/2
        userProfileImg.layer.cornerRadius = userProfileImg.frame.width / 2
    }
}
