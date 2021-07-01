//
//  TabBarDelegate.swift
//  MoodyCapital
//
//  Created by Garrett Moody on 6/24/21.
//

import UIKit

class MySubclassedTabBarController: UITabBarController {
    

    override func viewDidLoad() {
      super.viewDidLoad()
      delegate = self
        self.selectedIndex = 1
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        UITabBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

            for i in 0 ..< self.tabBar.items!.count {

                switch i {

                case 0:

                    tabBar.items?[i].title = "Dashboard"
                    let firstTab = self.tabBar.items![i] as UITabBarItem
                    firstTab.image = UIImage(systemName: "terminal")
                case 1:

                    tabBar.items?[i].title = "Home"
                    let firstTab = self.tabBar.items![i] as UITabBarItem
                    firstTab.image = UIImage(systemName: "ticket")
                case 2:

                    tabBar.items?[i].title = "Settings"
                    let firstTab = self.tabBar.items![i] as UITabBarItem
                    firstTab.image = UIImage(systemName: "gear")
                    

                default:
                    break
                }
            }
    }
}

extension MySubclassedTabBarController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
          return false // Make sure you want this as false
        }

        if fromView != toView {
          UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }

        return true
    }
}
