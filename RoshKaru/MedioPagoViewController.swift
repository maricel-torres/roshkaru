//  MedioPagoViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

class MedioPagoViewController: UIViewController {
    var accessToken:String?
    var selectTipoPago: CargaTarjetaTableViewController.PaymentType?
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.accessToken = "ca6dfba0-8f01-401e-bc0c-c04607a3ee0b"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ActionTarjeta(_ sender: Any) {
        self.selectTipoPago = .credit_card
           performSegue(withIdentifier: "tarjeta", sender: accessToken)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "tarjeta"{
            if let nexviewcontroller  = segue.destination as? CargaTarjetaTableViewController {
                nexviewcontroller.accessToken = self.accessToken
                nexviewcontroller.paymentType = self.selectTipoPago
            }
        }
    }
    
//    enum PaymentType: String {
//        case credit_card
//        case cash
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
