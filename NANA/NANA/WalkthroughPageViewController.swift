//
//  WalkthroughPageViewController.swift
//  NANA
//
//  Created by 안현정 on 2021/09/30.
//

import UIKit

protocol WalkthroughPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageViewController: UIPageViewController {

    var pageHeadings = [NSLocalizedString("매일 일기를 쓰면서 \n 나만의 정원을 가꾸어나가요", comment: "매일 일기를 쓰면서 나만의 정원을 가꾸어나가요"), NSLocalizedString("일기를 쓰면 받는 포인트로 \n 원하는 테마의 정원 PICK", comment: "일기를 쓰면 받는 포인트로 원하는 테마의 정원 PICK"), NSLocalizedString("나의 일상 속 다이어리 가든", comment: "나의 일상 속 다이어리 가든")]
    var pageImages = ["diaryGarden_logo_title", "intro_02_02", "intro_03"]
    var pageSubHeadings = [NSLocalizedString("정원을 꾸미는 재미로 꾸준히 일기를 쓰는 습관 형성", comment: "Walkthrough description #1"),
                           NSLocalizedString("일기를 작성할 때 마다 아이템이 \n 하나씩 심어지며 정원 완성", comment: "Walkthrough description #2"),
                           NSLocalizedString("오늘부터 나만의 정원을 가꾸며 하루를 보내볼까요?", comment: "Walkthrough descriptionn #3")]

    var currentIndex = 0
    
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source to itself
        dataSource = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
        delegate = self
    }
 
    // MARK: - Navigation
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }

}

extension WalkthroughPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
}

extension WalkthroughPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                
                currentIndex = contentViewController.index
                
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
            }
        
        }
    }
    
}
