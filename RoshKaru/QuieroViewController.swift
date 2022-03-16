//
//  QuieroViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

class QuieroViewController: UIViewController {
    var accesstoken: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func quieroComer(_ sender: Any) {
        performSegue(withIdentifier: "idubicacion", sender: accesstoken)
    }
    
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
