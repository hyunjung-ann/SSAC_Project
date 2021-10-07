//
//  SoundManager.swift
//  Card Game
//
//  Created by 안현정 on 2021/10/07.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer: AVAudioPlayer?
    
    //오디오 플레이어 속성
    enum SoundEffect {
        
        case Flip
        case shuffle
        case match
        case nomatch
    }
    
   static func playSound(_ effect:SoundEffect) {
        var soundFilename = ""
        
        //재생할 사운드 효과를 결정하고 적절한 파일이름을 설정
        switch effect {
        case .Flip:
            soundFilename = "cardflip"
            
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"
            
        }
        
        //번들 내부에 사운드 파일에 대한 경로를 가짐
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("couldn't find sound file \(soundFilename) in the bundle")
            return
        }
        
        // 문자열에서 URL 객체를 생성
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        
        do { //오류를 발생시키는 메소드의 경우, 명령문을 do catch 블록 내부에 넣음
            //오디오 플레이어 객체 생성
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            //오디오 플레이어 재생
            audioPlayer?.play()
        }
        catch {
        //오디오 플레이어 객체 만들 수 없음
            print("\(soundFilename) 파일에 대한 오디오 플레이어 객체를 만들 수 없음 ")
        }
    }
}
