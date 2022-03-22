//
//  HechoViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

class HechoViewController: UIViewController {
    var BASEURL = "https://phoebe.roshka.com/eat"
    var accessToken: String? 
    var cartKey: String?
    var paymentMethodKey: String?
    var total: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        pay_cart(accessToken: accessToken!, cartKey: cartKey, paymentMethodKey: paymentMethodKey, total: total)
        // Do any additional setup after loading the view.
    }
    
    func pay_cart(accessToken:String, cartKey: String?, paymentMethodKey: String?, total: Int?) {
        var urlComponents = URLComponents(string: "\(BASEURL)/pay_cart")!
        var queryItems: [URLQueryItem] = [
            AccessTokenQueryItem(accessToken),
            URLQueryItem(name: "cartKey", value: cartKey),
            URLQueryItem(name: "paymentMethodKey", value: paymentMethodKey),
            URLQueryItem(name: "total", value: String(total!))
        ]
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        print(url.absoluteString)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                self.hud?.hide(animated: true)
//            }
            if let error = error {
                print(error);
            } else if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                if let json = json {
                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                    
                } else {
                    self.successReally(data)
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
    func AccessTokenQueryItem(_ at: String ) -> URLQueryItem {
        URLQueryItem(name: "accessToken", value: at)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        false
    }
    @IBAction func OkAction(_ sender: Any) {
        performSegue(withIdentifier: "principal", sender: nil)
        //self.navigationController!.popToRootViewController(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "principal"{
            if let nextviewcontroller  = segue.destination as? PrincipalTableViewController {
                nextviewcontroller.accessToken = self.accessToken
            }
        }
    }
}
