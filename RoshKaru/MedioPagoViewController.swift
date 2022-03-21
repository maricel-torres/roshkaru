//  MedioPagoViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class MedioPagoViewController: UIViewController {
    
    @IBOutlet weak var tarjeta: MDCButton!
    @IBOutlet weak var efectivo: MDCButton!
    
    var accessToken:String?
    var selectTipoPago: CargaTarjetaTableViewController.PaymentType?
    override func viewDidLoad() {
        super.viewDidLoad()
        tarjeta.accessibilityLabel = "Create"
        tarjeta.setTitle("TARJETA", for: .normal)
        tarjeta.setTitleColor(.white, for: .normal)
        tarjeta.backgroundColor = .systemBlue
        tarjeta.layer.cornerRadius = 18

        efectivo.accessibilityLabel = "Create"
        efectivo.setTitle("EFECTIVO", for: .normal)
        efectivo.setTitleColor(.white, for: .normal)
        efectivo.backgroundColor = .systemBlue
        efectivo.layer.cornerRadius = 18
    }
    
    
    @IBAction func ActionTarjeta(_ sender: Any) {
        self.selectTipoPago = .credit_card
    }
    
    
    @IBAction func ActionEfectivo(_ sender: Any) {
        self.selectTipoPago = .cash
        add_payment_method(accessToken: self.accessToken!,
                           type: .cash, cardHolderName: nil,
                           cardNumbers: nil,
                           cardExpirationMonth: nil,
                           cardExpirationYear: nil,
                           cardSecurityCode: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "tarjeta"{
            if let nexviewcontroller  = segue.destination as? CargaTarjetaTableViewController {
                nexviewcontroller.accessToken = self.accessToken
                nexviewcontroller.paymentType = self.selectTipoPago
            }
        }
        if segue.identifier ==  "efectivo"{
            if let nexviewcontroller  = segue.destination as? ListPaymentMethod {
                nexviewcontroller.accessToken = self.accessToken
            }
        }
    }
    
    
    func add_payment_method(accessToken: String,
                                   type:PaymentType,
                                   cardHolderName: String?,
                                   cardNumbers: String?,
                                   cardExpirationMonth: Int?,
                                   cardExpirationYear: Int?,
                                   cardSecurityCode: String?
    ) {
        let BASEURL = "https://phoebe.roshka.com/eat"
        var urlComponents = URLComponents(string: "\(BASEURL)/add_payment_method")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "type", value: type.rawValue),
            AccessTokenQueryItem(accessToken)
        ]
        if let cardHolderName = cardHolderName {
            queryItems.append(URLQueryItem(name: "cardHolderName", value: cardHolderName))
        }
        if let cardNumbers = cardNumbers {
            queryItems.append(URLQueryItem(name: "cardNumbers", value: cardNumbers))
        }
        if let cardExpirationMonth = cardExpirationMonth {
            queryItems.append(URLQueryItem(name: "cardExpirationMonth", value: String(cardExpirationMonth)))
        }
        if let cardExpirationYear = cardExpirationYear {
            queryItems.append(URLQueryItem(name: "cardExpirationYear", value: String(cardExpirationYear)))
        }
        if let cardSecurityCode = cardSecurityCode {
            queryItems.append(URLQueryItem(name: "cardSecurityCode", value: cardSecurityCode))
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
                } else {
                    print("# Success")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }.resume()
        
    }
    
    func AccessTokenQueryItem(_ at: String ) -> URLQueryItem {
        URLQueryItem(name: "accessToken", value: at)
    }
    
    enum PaymentType: String {
        case credit_card
        case cash
    }

}
