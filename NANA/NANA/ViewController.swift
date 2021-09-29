//
//  ViewController.swift
//  NANA
//
//  Created by 안현정 on 2021/09/29.
//

import UIKit
import PagingKit

class ViewController: UIViewController {
    
    static var viewController: (UIColor) -> UIViewController = { (color) in
          let vc = UIViewController()
           vc.view.backgroundColor = color
           return vc
       }
       
       var dataSource = [(menuTitle: "전체", vc: viewController(#colorLiteral(red: 0.01809065173, green: 0.08367160382, blue: 0.1579357816, alpha: 1))), (menuTitle: "기본 카테고리", vc: viewController(#colorLiteral(red: 0.01809065173, green: 0.08367160382, blue: 0.1579357816, alpha: 1))), (menuTitle: "취미 🕹", vc: viewController(#colorLiteral(red: 0.01809065173, green: 0.08367160382, blue: 0.1579357816, alpha: 1))),(menuTitle: "", vc: viewController(#colorLiteral(red: 0.01809065173, green: 0.08367160382, blue: 0.1579357816, alpha: 1))),(menuTitle: "", vc: viewController(#colorLiteral(red: 0.01809065173, green: 0.08367160382, blue: 0.1579357816, alpha: 1)))]
    
    var menuViewController: PagingMenuViewController!
       var contentViewController: PagingContentViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
      //  menuViewController.register(type: TitleLabelMenuViewCell.self, forCellWithReuseIdentifier: "TitleLabelMenuCell")
       menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
       // menuViewController.registerFocusView(view: UnderlineFocusView())

 
        
        menuViewController.reloadData()
        contentViewController.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let vc = segue.destination as? PagingMenuViewController {
             menuViewController = vc
             menuViewController.dataSource = self
            menuViewController.delegate = self
         } else if let vc = segue.destination as? PagingContentViewController {
             contentViewController = vc
             contentViewController.dataSource = self
             contentViewController.delegate = self
         }
     }


}

//MARK:- 메뉴 데이터 소스 / 델리겟

extension ViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 100
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
      let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
       // let cell = viewController.dequeueReusableCell(withReuseIdentifier: "TitleLabelMenuCell", for: index) as! TitleLabelMenuViewCell
        
        cell.titleLabel.text = dataSource[index].menuTitle
        cell.titleLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
       cell.titleLabel.highlightedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
}

extension ViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

//MARK:- 콘텐츠 데이터소스 / 델리겟

extension ViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].vc
    }
}

extension ViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        //내용이 스크롤 되면 메뉴를 스크롤한다.
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
