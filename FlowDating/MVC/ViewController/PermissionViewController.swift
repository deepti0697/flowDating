//
//  PermissionViewController.swift
//  FlowDating
//
//  Created by deepti on 22/02/21.
//

import UIKit
import CoreLocation
import AVFoundation
class PermissionViewController: UIViewController {

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func CameraLocation(){
        let locStatus = CLLocationManager.authorizationStatus()
          switch locStatus {
             case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                location()
             return
             case .denied, .restricted:
                let alert = UIAlertController(title: "Location Services are disabled", message: "Please enable Location Services in your Settings", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                location()
             return
             case .authorizedAlways, .authorizedWhenInUse:
                location()
             break
          @unknown default:
            locationManager.requestWhenInUseAuthorization()
        
          break
            
          }
    }
    func location(){
        //Camera
        DispatchQueue.main.async {
          AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
              if response {
                DispatchQueue.main.async {
                    self.openHomeViewController()
                }
              } else {
                DispatchQueue.main.async {
                self.openHomeViewController()
              }
              }
          }
        }

    }
    
    @IBAction func allow(_ sender: Any) {
        AppHelper.setBoolForKey(true, key: ServiceKeys.isPermissionEnabled)
        DispatchQueue.main.async {
            
            self.CameraLocation()
        }
    }
    func openHomeViewController() {
        appdelegate.setinitalViewController()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
