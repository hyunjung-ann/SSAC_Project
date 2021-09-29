//
//  ToDoViewController.swift
//  OneMore_Project
//
//  Created by 안현정 on 2021/09/27.
//

import PagingKit
import UIKit


class ToDoViewController: UIViewController {
    
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    //뷰컨트롤러 컬러 입히는 과정
    static var viewController: (UIColor) -> UIViewController = { (color) in
       let vc = UIViewController()
        vc.view.backgroundColor = color
        return vc
    }
    
    //데이터소스는 각각의 뷰컨트롤러를 가짐 (하나의 배열은 menuTitle, vc 가짐)
    var dataSource = [(menuTitle: "test1", vc: viewController(.red)), (menuTitle: "test2", vc: viewController(.red)), (menuTitle: "test3", vc: viewController(.red))]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ToDoVC - viewDidLoad() called")
        

        //menuViewController에 MenuCell,FocusView 연결
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        //MenuCell nib파일을 통해서 메뉴 등록 -> FocusView nib파일 등록
        
        //데이터로드
        menuViewController.reloadData()
        contentViewController.reloadData()


    }
    
    //현재 뷰컨트롤러에서 넘어가는 segue 중 종착지가 PagingMenuViewController라면 menuViewController 사용
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self //데이터소스 연결
            menuViewController.delegate = self
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self
            contentViewController.delegate = self
        }
    }

}

//MARK: - Menu 데이터소스

extension ToDoViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count //메뉴 3개 들어감
    }
    
    //각 메뉴 아이템에 대한 가로 넓이 100
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 100
    }
    
    //셀 적용
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        cell.titleLabel.text = dataSource[index].menuTitle
        return cell
    }
}

extension ToDoViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}


//MARK: - Content 데이터 소스

extension ToDoViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    //해당하는 뷰컨트롤러에 컨텐츠 적용
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].vc
    }
}

extension ToDoViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
