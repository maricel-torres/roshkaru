//
//  QuieroViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class QuieroViewController: UIViewController {
    
    
    @IBOutlet weak var comer: MDCButton!
    
    @IBOutlet weak var cocinar: MDCButton!
    var accesstoken: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        //comer.addTarget(self, action: #selector(SendNumber(_:)), for: .touchUpInside)
        comer.accessibilityLabel = "Create"
        comer.setTitle("COMER", for: .normal)
        comer.setTitleColor(.white, for: .normal)
        comer.backgroundColor = .systemBlue
        comer.layer.cornerRadius = 18
        
        cocinar.accessibilityLabel = "Create"
        cocinar.setTitle("COCINAR", for: .normal)
        cocinar.setTitleColor(.white, for: .normal)
        cocinar.backgroundColor = .systemBlue
        cocinar.layer.cornerRadius = 18
        // Do any additional setup after loading the view.
    }
    
    
    

    @IBAction func quieroComer(_ sender: Any) {
        self.toggle_traits(accessToken: self.accesstoken!, trait: .eater)
    }
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "idubicacion"{
            if let nexviewcontroller  = segue.destination as? UbicacionViewController {
                nexviewcontroller.accessToken = self.accesstoken
            }
        }
    }
    
    enum Trait: String {
        case cook
        case eater
    }
    
    func toggle_traits(accessToken:String, trait: Trait) {
        let BASEURL = "https://phoebe.roshka.com/eat"
        var urlComponents = URLComponents(string: "\(BASEURL)/toggle_traits")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "accessToken", value: accessToken),
            URLQueryItem(name: "traits", value: trait.rawValue),
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
                    self.successReally(data)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "idubicacion", sender: nil)
                    }
                }
                
                
            }
        }.resume()
        
    }
    
    func successReally(_ data: Data) {
        if let str = String(data: data, encoding: .utf8), str.count > 0  {
            print("_WOOOPS_______________________________________________\n\(str)")
        } else {
            print("# Success")
        }
    }

}
