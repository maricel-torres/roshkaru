//
//  DireccionViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

class DireccionViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewPricipal: UIStackView!
    @IBOutlet weak var streetName: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var neighborhood: UITextField!
    @IBOutlet weak var reference: UITextField!
    
    var accessToken:String?
    
    override func viewDidLoad() {
        self.accessToken = "3rwr345r43tret5654y6egret65hn"
        super.viewDidLoad()
        stackViewPricipal.spacing = 20
        stackView.spacing = 10
        
        
    }
    // MARK: - Navigation

    @IBAction func sendData(_ sender: Any) {
        self.set_address(accessToken: self.accessToken!,
                             addressType: .delivery,
                             streetName: self.streetName.text!,
                             number: self.number.text!,
                             neighborhood: self.neighborhood.text!,
                             reference: self.reference.text)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "principal" {
            if let nextViewController = segue.destination as? PrincipalTableViewController {
                nextViewController.sender = self.accessToken
            }
        }
    }
    
    
    enum AddressType: String {
        case delivery, cook_site
    }

    func set_address(accessToken: String, addressType:AddressType, streetName:String, number:String, neighborhood:String, reference:String?) {
        let BASEURL = "https://texo.thebirdmaker.com/eat"
        var urlComponents = URLComponents(string: "\(BASEURL)/set_address")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "addressType", value: addressType.rawValue),
            URLQueryItem(name: "streetName", value: streetName),
            URLQueryItem(name: "number", value: number),
            URLQueryItem(name: "neighborhood", value: neighborhood),
            URLQueryItem(name: "accessToken", value: accessToken),
            URLQueryItem(name: "replace", value: String(true)),
        ]
        if let reference = reference {
            queryItems.append(URLQueryItem(name: "reference", value: reference))
        }
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
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "principal", sender: self.accessToken!)
                    }
                } else {
                    print("# Success")
                }
                
                
            }
        }.resume()
        
    }
    
}
