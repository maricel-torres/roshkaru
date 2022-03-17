//
//  QuieroViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

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
        comer.backgroundColor = .systemRed
        comer.layer.cornerRadius = 18
        
        cocinar.accessibilityLabel = "Create"
        cocinar.setTitle("COCINAR", for: .normal)
        cocinar.setTitleColor(.white, for: .normal)
        cocinar.backgroundColor = .systemRed
        cocinar.layer.cornerRadius = 18
        // Do any additional setup after loading the view.
    }
    
    
    
//    @IBAction func quieroComer(_ sender: Any) {
//        performSegue(withIdentifier: "idubicacion", sender: accesstoken)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "idubicacion"{
            if let nexviewcontroller  = segue.destination as? UbicacionViewController {
                nexviewcontroller.accessToken = self.accesstoken
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
