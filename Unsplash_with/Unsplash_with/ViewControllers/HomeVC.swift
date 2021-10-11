//
//  ViewController.swift
//  Unsplash_with
//
//  Created by 안현정 on 2021/10/10.
//

import UIKit
import Toast_Swift

class HomeVC: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    

    //MARK:- override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("HomeVC - viewDidLoad() 호출됨 ")
        
        //ui 설정 - 1) 테두리 둥글게
        self.searchButton.layer.cornerRadius = 10
        
        //ui 설정 - 2) searchbar 테두리 선 없애기
        self.searchBar.searchBarStyle = .minimal
        
        //delegate 감지해주기 위해 설정 - 프로토콜 공부하기 !
        self.searchBar.delegate = self
    }

    
    //MARK:- IBAction methods
    
    //선택된 인덱스에서 버튼 눌렀을 때 해당 인덱스 표시
    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
        print("HomeVC - onSearchButtonClicked() called / selectedIndex  \(searchFilterSegment.selectedSegmentIndex) ")
        
        var segueId: String = ""
        
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            print("사진 화면으로 이동")
            segueId = "goToPhotoCollectionVC"
        case 1:
            print("사용자 화면으로 이동")
            segueId = "goToUserListVC"
        default:
            print("default")
            segueId = "goToPhotoCollectionVC"
        }
        
        //화면 이동 - homevc 화면에서 이동한다 
        self.performSegue(withIdentifier: segueId, sender: self)
    }
    
    @IBAction func searchFilterValueChanged(_ sender: UISegmentedControl) {
        print("HomeVC - searchFilterValueChanged() called /index: \(sender.selectedSegmentIndex) ")
        
        //선택된 인덱스마다 플레이스 홀더 변경하기
        var searchBarTitle = ""
        
        switch sender.selectedSegmentIndex {
        case 0:
            searchBarTitle = "사진 키워드"
        case 1:
            searchBarTitle = "사용자 이름"
        default:
            searchBarTitle = "사진 키워드"
        }
        
        self.searchBar.placeholder = searchBarTitle + " 입력"
        
        self.searchBar.becomeFirstResponder()   //포커싱 - 키보드 올라오게하기
       // self.searchBar.resignFirstResponder() //포커싱 해제
    }
    
    //MARK:- UISearchBar Delegate methods
    
    //searchbar 입력한 텍스트 표시
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("HomeVC- searchBar textDidChange() searchText: \(searchText) ")
        
        //사용자가 입력한 글자가 없다면 searchButton 숨김
        if (searchText.isEmpty) {
            self.searchButton.isHidden = true
            searchBar.resignFirstResponder() //포커싱 해제
        } else {
            self.searchButton.isHidden = false
        }
        
    }
    
    //글자가 입력될 때 들어온 글자 수를 알 수 있다.
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //text 값이 비어있다면 0을 넣음 (언래핑)
        let inputTextCount = searchBar.text?.appending(text).count ?? 0
        
        print("shouldChangeTextIn : \(inputTextCount)")
        
        //Toast 사용 - inputTextCount가 12자가 넘을 시, 공지
        if (inputTextCount >= 12){
            // toast with a specific duration and position
            self.view.makeToast("📢 12자까지만 입력 가능합니다", duration: 3.0, position: .center)
        }
        
        if inputTextCount <= 12 {
            return true
        } else {
            
        }
      return true
    }
    
}

