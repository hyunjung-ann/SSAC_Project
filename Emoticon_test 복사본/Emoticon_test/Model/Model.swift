//
//  Model.swift
//  Emoticon_test
//
//  Created by 안현정 on 2021/09/21.
//

import Foundation

class Emoticon {
    var content: String
    
    init(content:String) {
        self.content = content
    }
    
    //더미데이터 저장하는 배열
    static var dummyEmoticonList = [
    Emoticon(content: "Lorem Ipsum")]
}
