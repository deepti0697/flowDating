//
//  AppDelegate.swift
//  FlowDating
//
//  Created by deepti on 25/01/21.
//

import UIKit
import FAPanels
import AVFoundation
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var currentNavController:UINavigationController?
  var tabBarController = UITabBarController()
    var isComingFromSideMenu = false
  var navigationController:UINavigationController?
  let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
  var selectedVC : UINavigationController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let nv4 = UINavigationController(rootViewController: vc1)
      
        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func setHomeView() {
        
        let storyBoard  = UIStoryboard(name: "Home", bundle: nil)
        
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "MatchesVC") as! MatchesVC
        let nv1 = UINavigationController(rootViewController: vc1)
        // nv1.restorationIdentifier = "gigListViewController"
         self.selectedVC = nv1
        var nv2 : UINavigationController!
        
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "VC_Messages") as! VC_Messages
        nv2 = UINavigationController(rootViewController: vc2)
        //  nv2.restorationIdentifier = "gigsListViewController"
        
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "MatchesVC") as! MatchesVC
        let nv3 = UINavigationController(rootViewController: vc3)
        
        //  nv3.restorationIdentifier = "communityViewController"
        
        
        let vc4 = storyBoard.instantiateViewController(withIdentifier: "VC_Interests") as! VC_Interests
        let nv4 = UINavigationController(rootViewController: vc4)
        //   nv4.restorationIdentifier = "chatsListViewController"
        
        
       
      
        // nv5.restorationIdentifier = "logoutViewController"
        
        nv1.tabBarItem = UITabBarItem.init(title: "first", image: UIImage(named: "Hurt"), selectedImage: UIImage(named: "SHurt"))
        nv2.tabBarItem = UITabBarItem.init(title: "secnds", image: UIImage(named: "Chat"), selectedImage: UIImage(named: "SChat"))
        nv3.tabBarItem = UITabBarItem.init(title: "third", image: UIImage(named: "Saved"), selectedImage: UIImage(named: "SSaved"))
        nv4.tabBarItem = UITabBarItem.init(title: "fourth", image: UIImage(named: "Mystery"), selectedImage: UIImage(named: "SMystery"))
        
       // nv3.tabBarItem.isEnabled = false
       
        nv1.tabBarItem.title = "Matches"
        nv2.tabBarItem.title = "Chat"
        nv3.tabBarItem.title = "Saved"
        nv4.tabBarItem.title = "Mystery"
     
        
        
        // Fallback on earlier versions
        tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBarController.tabBar.layer.shadowRadius = 5
        tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController.tabBar.layer.shadowOpacity = 0.5
        
        tabBarController.tabBar.shadowImage = nil
       
        tabBarController.viewControllers = [nv1, nv2, nv3, nv4]
        tabBarController.tabBar.tintColor = UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1)
        tabBarController.selectedIndex = 0
        
        customizeTabBarView()
        customizeTabBarView()
        if self.navigationController == nil {

            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let leftMenuVC = storyboard.instantiateViewController(withIdentifier: "MatchesVC") as! MatchesVC

            let rootController = FAPanelController()
            rootController.configs.bounceOnRightPanelOpen = false
            rootController.configs.canLeftSwipe = false
            rootController.configs.canRightSwipe = false

            rootController.rightPanelPosition = .back
            rootController.configs.maxAnimDuration = 0.30
            rootController.configs.leftPanelWidth = UIScreen.main.bounds.width * 1
            _ = rootController.center(self.tabBarController).left(leftMenuVC)
            self.window?.rootViewController = rootController
            self.window?.makeKeyAndVisible()
        }else {
            self.navigationController?.present(tabBarController, animated: true, completion: {
                
            })
        }
      
      

    }



    fileprivate func customizeTabBarView() {
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: .normal)
    }
}

