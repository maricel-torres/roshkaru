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
  //  @IBOutlet weak var pedidos: UITableViewCell!
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
        btnConfirm.backgroundColor = .systemBlue
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
            if let nextviewcontroller  = segue.destination as? HechoViewController {
                nextviewcontroller.accessToken = self.accessToken
                nextviewcontroller.cartKey = self.carKey
                nextviewcontroller.total = self.totalPagar
                nextviewcontroller.paymentMethodKey = self.metodoPagoKey
                
            }
        }
    }    
    func AccessTokenQueryItem(_ at: String ) -> URLQueryItem {
        URLQueryItem(name: "accessToken", value: at)
    }
    
    func successReally(_ data: Data) {
        if let str = String(data: data, encoding: .utf8), str.count > 0  {
            print("_WOOOPS_______________________________________________\n\(str)")
        } else {
            print("#Success")
        }
    }
    func close_cart(accessToken: String, cartKey: String, confirm: Bool) {
        
        var urlComponents = URLComponents(string: "\(BASEURL)/close_cart")!
        let queryItems: [URLQueryItem] = [
            self.AccessTokenQueryItem(accessToken),
            URLQueryItem(name: "cartKey", value: cartKey),
            URLQueryItem(name: "confirm", value: String(confirm)),
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
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "hecho", sender: self.accessToken)
                    }
                } else {
                    self.successReally(data)
                }
            }
        }.resume()
    }
    
    @IBAction func ConfirmarPedidoAction(_ sender: Any) {
        close_cart(accessToken: accessToken!, cartKey: carKey!, confirm: true)
    }
    
}
