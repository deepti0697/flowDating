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
import Firebase
import FirebaseMessaging
import GoogleMaps
import GooglePlaces
@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    let gcmMessageIDKey = "gcm.message_id"
    var window: UIWindow?
    var currentNavController:UINavigationController?
    var tabBarController = UITabBarController()
    var isComingFromSideMenu = false
    var navigationController:UINavigationController?
    let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    var selectedVC : UINavigationController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSPlacesClient.provideAPIKey("AIzaSyBe2m3BWawVp5q4maj3Q1_PmH0cYrhvrvY")
        GMSServices.provideAPIKey("AIzaSyBe2m3BWawVp5q4maj3Q1_PmH0cYrhvrvY")
        self.window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        self.registerForRemoteNotification()
        
        Messaging.messaging().delegate = self
        sleep(3)
        self.GetFCMToken()
        if  (AppHelper.getStringForKey(ServiceKeys.token) == "") {
            if AppHelper.getBoolForKey(ServiceKeys.isPermissionEnabled) {
                setinitalViewController()
            }
            else {
                let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
                let vc1 = storyBoard.instantiateViewController(withIdentifier: "PermissionViewController") as! PermissionViewController
                let nv4 = UINavigationController(rootViewController: vc1)

                self.window?.rootViewController = nv4
                self.window?.makeKeyAndVisible()
            }
         
//                appdelegate.setHomeView()
//                setHomeView(selectedIndex: 0)
            }
        
        else {
    if AppHelper.getStringForKey(ServiceKeys.profile_Screen) == "1" {
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "CompleteProfile1VC") as! CompleteProfile1VC
        let nv4 = UINavigationController(rootViewController: vc1)
        vc1.isComingFromRegistration = true
//        vc1.backButtonOutlt.isHidden = true
        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
    }
    else if AppHelper.getStringForKey(ServiceKeys.profile_Screen) == "2" {
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "CompleteProfile2VC") as! CompleteProfile2VC
        let nv4 = UINavigationController(rootViewController: vc1)
//        vc1.backBtnOutlt.isHidden = true
        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
    }
    else {
            let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let nv4 = UINavigationController(rootViewController: vc1)

            self.window?.rootViewController = nv4
            self.window?.makeKeyAndVisible()
        }
    
       
            
            
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func setinitalViewController() {
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let nv4 = UINavigationController(rootViewController: vc1)

        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
    }
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
        
        nv1.tabBarItem = UITabBarItem.init(title: "first", image: UIImage(named: "Hurt")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SHurt")?.withRenderingMode(.alwaysOriginal))
        nv2.tabBarItem = UITabBarItem.init(title: "secnds", image: UIImage(named: "Chat")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SChat")?.withRenderingMode(.alwaysOriginal))
        nv3.tabBarItem = UITabBarItem.init(title: "third", image: UIImage(named: "Saved")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SSaved")?.withRenderingMode(.alwaysOriginal))
        nv4.tabBarItem = UITabBarItem.init(title: "fourth", image: UIImage(named: "Mystery")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SMystery")?.withRenderingMode(.alwaysOriginal))
        
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
    func setHomeVC(){
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let nv4 = UINavigationController(rootViewController: vc1)
        
        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
    }
    
    
    fileprivate func customizeTabBarView() {
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: .normal)
    }
}

extension AppDelegate:UNUserNotificationCenterDelegate,MessagingDelegate {
    //MARK: - Register User Notifications
    
    func registerForRemoteNotification() {
        
        if #available(iOS 10.0, *)
        {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
                if (granted)
                {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    
                }
                else{
                    AppDelegate.print("Notifications permission not given")
                }
            })
        }
        else
        {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    // MARK: - Remote Notification Methods // <= iOS 9.x
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        NSLog("didFailToRegisterForRemoteNotificationsWithError Error = %@", error.localizedDescription)
    }
    
    // MARK: - UNUserNotificationCenter Delegate // >= iOS 10
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            AppDelegate.print("Message ID--->: \(messageID)")
        }
        
        // Print full message.
        AppDelegate.print(userInfo)
        
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            AppDelegate.print("Message ID: \(messageID)")
        }
        
        // Print full message.
        AppDelegate.print(userInfo)
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            AppDelegate.print("Message ID: \(messageID)")
        }
        
        // Print full message.
        AppDelegate.print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            AppDelegate.print("Message ID: \(messageID)")
        }
        
        // Print full message.
        AppDelegate.print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func GetFCMToken()
    {
        
        Messaging.messaging().token { token, error in
            if let error = error {
                AppDelegate.print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                AppDelegate.print("FCM registration token: \(token)")
//                kAppDeviceId = "\(token)"
//                defaults[.DeviceToken] = kAppDeviceId
                AppHelper.setStringForKey("\(token)", key: ServiceKeys.device_token)
            }
        }
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        AppDelegate.print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    public static func print(_ items: Any..., separator: String = " ", terminator: String = "\n", _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        //#if targetEnvironment(simulator)
        let stringItem = items.map {"\($0)"} .joined(separator: separator)
        Swift.print("\(stringItem)", terminator: terminator)
        //#endif
    }
}
extension AppDelegate {
    
    private struct AssociatedKey {
        static var user  = ServiceKeys.saveUser
    }
    public var user: GetUserProfile? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.user) as? GetUserProfile
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKey.user, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
