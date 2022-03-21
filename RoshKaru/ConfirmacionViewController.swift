//
//  ConfirmacionViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

class ConfirmacionViewController: UIViewController {

    var accessToken: String?
    @IBOutlet weak var btnConfirm: MDCButton!
    @IBOutlet weak var verticalStack: UIStackView!
    var carKey:String?
    var totalPagar:Int?
    var metodoPagoKey:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnConfirm.setTitle("Confirmar", for: .normal)
        btnConfirm.setTitleColor(.white, for: .normal)
        btnConfirm.backgroundColor = .systemRed
        btnConfirm.sizeToFit()
        btnConfirm.layer.cornerRadius = 18
    }
    

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pedidoRealizado" {
            self.performSegue(withIdentifier: "principal", sender: self.accessToken!)
        }
    }

}
