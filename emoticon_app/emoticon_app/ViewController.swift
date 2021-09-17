//
//  ViewController.swift
//  emoticon_app
//
//  Created by 안현정 on 2021/09/15.
//

import UIKit

/*class Emoticon: Object {
    @objc dynamic var name = ""
}*/

class ViewController: UIViewController {

  
    @IBAction func button(_ sender: Any) {
    }
    @IBOutlet weak var CreateTableView: UITableView!
    
  /*  var notificationToken : NotificationToken?
    var realm: Realm?
    var items: Results<Emoticon>? */
    
    let contentArray = [
        "--",
        
        "ㅇㅅㅇ",
        
        "><",
        
        "^_^"
        
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
      
        /*
        //migration 필요할 때 데이터 초기화
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
        
        //Emoticon 데이터를 수집하는 코드
        items = realm?.objects(Emoticon.self)
        
        //push driven 작동시키는 코드
        notificationToken = realm?.observe({ (noti, realm) in
            self.CreateTableView.reloadData()
        })
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        notificationToken?.invalidate()
    }
} */
    }
