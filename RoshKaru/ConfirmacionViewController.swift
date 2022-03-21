//
//  ConfirmacionViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

class ConfirmacionViewController: UIViewController {

    @IBOutlet weak var monto: UILabel!
    @IBOutlet weak var pedidos: UITableViewCell!
    var accessToken: String?
    var hud: MBProgressHUD?
    @IBOutlet weak var btnConfirm: MDCButton!
    var carKey:String?
    var totalPagar:Int?
    var metodoPagoKey:String?
    var BASEURL = "https://phoebe.roshka.com/eat"
    @IBOutlet weak var total: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnConfirm.setTitle("Confirmar", for: .normal)
        btnConfirm.setTitleColor(.white, for: .normal)
        btnConfirm.backgroundColor = .systemRed
        btnConfirm.sizeToFit()
        btnConfirm.layer.cornerRadius = 18
        
        total.text = "Total:"
        monto.text = "\(String(describing: totalPagar!)) gs"

        
    }
    

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hecho" {
            if let nexviewcontroller  = segue.destination as? HechoViewController {
                nexviewcontroller.accessToken = self.accessToken
                nexviewcontroller.carKey = self.carKey
            }
        }
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
            DispatchQueue.main.async {
                self.hud?.hide(animated: true)
            }
            if let error = error {
                print(error);
            } else if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                if let json = json {
                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                    
                } else {
                    self.successReally(data)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "principal", sender: self.accessToken)
                    }
                }
            }
        }.resume()
    }
    
    func AccessTokenQueryItem(_ at: String ) -> URLQueryItem {
        URLQueryItem(name: "accessToken", value: at)
    }
    
    func successReally(_ data: Data) {
        if let str = String(data: data, encoding: .utf8), str.count > 0  {
            print("_WOOOPS_______________________________________________\n\(str)")
        } else {
            print("# Success")
        }
    }
}
