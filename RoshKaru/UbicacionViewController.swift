//
//  UbicacionViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import MapKit

class UbicacionViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttomSgte: UIButton!
    @IBOutlet weak var pinIcon: UIImageView!
    
    var accessToken:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accessToken = "ca6dfba0-8f01-401e-bc0c-c04607a3ee0b"
        let latitude    = -25.281818845574698
        let longitude   = -57.61052921667962
        
        let noLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let viewRegion = MKCoordinateRegion(center: noLocation, latitudinalMeters: 300, longitudinalMeters: 300)
        mapView.setRegion(viewRegion, animated: true)
    }
    
 
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let coordinate = self.mapView.centerCoordinate
        if let accessToken = self.accessToken {
            set_location(accessToken: accessToken, addressType: .delivery, latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "direccion" {
            if let nextViewController = segue.destination as? DireccionViewController {
                nextViewController.accessToken = self.accessToken
            }
        }
    }
    
    enum AddressType: String {
        case delivery, cook_site
    }

    func set_location(accessToken:String, addressType: AddressType, latitude: Double, longitude: Double ) {
        let BASEURL = "https://texo.thebirdmaker.com/eat"
        var urlComponents = URLComponents(string: "\(BASEURL)/set_location")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "addressType", value: addressType.rawValue),
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            URLQueryItem(name: "accessToken", value: accessToken),
            URLQueryItem(name: "replace", value: String(true)),
        ]
    
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        print(url.absoluteString)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error);
            } else if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                if let json = json {
                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                } else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "direccion", sender: self.accessToken!)
                    }
                    print("# Success")
                }
            }
        }.resume()
        
    }
    


}
