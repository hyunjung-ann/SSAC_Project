//
//  FirstViewController.swift
//  Emoticon_test
//
//  Created by 안현정 on 2021/09/21.
//

import UIKit

//UITableViewDelegate : 테이블 뷰를 어떻게 보여줄 것인가 ?
//UITableViewDataSource : 테이블 뷰의 셀은 총 몇 개? -> 두개의 프로토콜 최상단 추가
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    //context 가져오기
    //AppDelegate에게 강제 캐스트 -> 컨텍스트가 실제로 갈 수 있는 곳 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
   
 /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
           let target = models[indexPath.row]
           
           if let vc = segue.destination as? AddViewController{
               vc.emoticonList = target
           }
       } */
     


   private var models = [Emoticon]() //이모티콘 항목 배열
    

    override func viewDidLoad() {
      super.viewDidLoad()
      title = "Emoticon"
      tableView.delegate = self //델리게이트 할당
      tableView.dataSource = self //데이터소스 할당
      //delegate,datasorce 적용을 안하면 테이블뷰에 어떤 액션을 취했을 때(데이터 넘겨주기 등) 아무것도 못하게 된다.
   
    }
   
   // MARK: - TableViewDataSource
   
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return models.count //모델의 수 만큼 반환
 }
   

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let model = models[indexPath.row]
      //현재 이모티콘 항목은 N번째 위치
       let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
       //dequeReusableCell은 재활용 가능한 셀을 큐(queue)의 형태로 추가/제거
       //for : 셀의 위치를 ​​지정하는 색인 ​​경로, 항상 데이터 원본 개체에서 제공하는 인덱스 경로를 지정
       //cell: 아까 추가한 테이블 뷰 셀의 구분자(identifier)를 적는 곳 / 이 구분자를 통해 셀을 가져오고 그 셀을 재활용

      cell.textLabel?.text = model.content //텍스트레벨에 나타날 텍스트는 modeld의 content이다.
      return cell
  }
      

   

   //MARK:- CRUD
      
    //모든 항목을 가져와라 -> R
    func getAllItems() {
        //데이터베이스에서 이모티콘 모든 항목을 가져오기
      do {
      models =  try context.fetch(Emoticon.fetchRequest())//요청 가져오기
         DispatchQueue.main.async { //ui관련 동작 수행
            self.tableView.reloadData() //테이블뷰에 다시 재업로드데이트 호출
         }
      } catch {
         //error
      }
    }
   
   
    //항목을 생성하는 기능 -> C
    func createItem(content: String) {
     let newItem = Emoticon(context: context) //새 항목이 이모티콘 목록 항목 + 컨텍스트를 사용하여 새 항목을 생성
      newItem.content = content //속성 지정
      
      do {
         try context.save() //저장
      }
      catch {
         
      }
    }
    
    //항목을 삭제하는 기능 + 이모티콘 목록 불러옴 -> D
    func deleteItem(item: Emoticon) {
      context.delete(item)
      
      do {
         try context.save() //저장
      }
      catch {
         
      }
    }
    
    //업데이트 + 이모티콘 목록 불러옴 -> U
    //항목을 다시 전달하면 계속 진행,항목의 'content'를 업데이트하여 다음을 수행
   func updateItem(item: Emoticon, newContent: String){
      item.content = newContent
       
      do {
         try context.save() //저장
      }
      catch {
         
      }
    }

    
    
// MARK: - METHOD
    
    /// 버튼을 클릭하면 호출되는 메소드
    
    // SecondViewController를 화면에 띄운다.
    
    // 1. UIViewController 인스턴스를 생성한다.
    // 옵셔널 바인딩
  /* @IBAction func buttonDidTapped(_ sender: UIButton) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "myCell") as! AddViewController
    vc.delegate = self
    vc.modalPresentationStyle = .fullScreen

    }
    
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

     */
 }

