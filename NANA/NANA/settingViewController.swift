//
//  settingViewController.swift
//  NANA
//
//  Created by 안현정 on 2021/09/30.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    struct Name {
           var name: String
       }
    
    let cellIdentifier = "MyCell"
    let sections = ["Setting", "Back-up"]
    
    let myData = [
     Name(name: "앱 설정"),
     Name(name: "자동 알림 설정"),
     Name(name: "위젯 설정"),
     Name(name: "위젯 사용 방법")
    ]
    
    let myData2 = [
        Name(name: "데이터 불러오기"),
        Name(name: "백업하기"),
        Name(name: "데이터 지우기"),
        Name(name: "리뷰 남기기")
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(section == 0)
            {
                return myData.count
            }
            return myData2.count
        }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return sections.count
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyTableViewCell = self.myTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
        if( indexPath.section == 0 )
        {
    
            cell.nameLabel.text = myData[indexPath.row].name
        }else{
       
            cell.nameLabel.text = myData2[indexPath.row].name

        }
      
        
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                    
        cell.accessoryView = switchView
        
        return cell
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        print("Table row switch changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return sections[section]
           
       }
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.tableFooterView = UIView()
        myTableView.delegate = self
       myTableView.dataSource = self
    }
}
