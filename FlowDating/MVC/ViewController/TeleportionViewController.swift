//
//  TeleportionViewController.swift
//  FlowDating
//
//  Created by deepti on 11/03/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import CoreLocation
class TeleportionViewController: UIViewController {

    var latitude:String?
    var  longitude:String?
    
    @IBOutlet weak var selectPlacesLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func openteleportion(_ sender: Any) {
        openPlacePicker()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - GMSMapViewDelegate
extension TeleportionViewController :  GMSAutocompleteViewControllerDelegate{
    

    // Present the Autocomplete view controller when the button is pressed.
    func openPlacePicker() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
//        self.navigationController?.show(autocompleteController, sender: nil)
//        self.navigationController?.pushViewController(autocompleteController, animated: true)
        self.navigationController?.present(autocompleteController, animated: false, completion: nil)
    }
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //TODO-
        //        self.reverseGeocodeCoordinate(place.coordinate)
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress!)")
        print("Place attributions: \(String(describing: place.attributions))")
        
        if let formattedAddress = place.formattedAddress {
            self.selectPlacesLbl.text = formattedAddress
        }
        self.selectPlacesLbl.text =  place.formattedAddress!
        latitude = String(place.coordinate.latitude)
        longitude = String(place.coordinate.longitude)
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
