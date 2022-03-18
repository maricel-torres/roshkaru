//  MedioPagoViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

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
        tarjeta.backgroundColor = .systemRed
        tarjeta.layer.cornerRadius = 18
        
        efectivo.accessibilityLabel = "Create"
        efectivo.setTitle("COCINAR", for: .normal)
        efectivo.setTitleColor(.white, for: .normal)
        efectivo.backgroundColor = .systemRed
        efectivo.layer.cornerRadius = 18
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
