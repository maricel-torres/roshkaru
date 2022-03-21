//
//  DatosViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import MBProgressHUD
import MaterialComponents.MaterialButtons

class DatosViewController: UIViewController {
    var hud: MBProgressHUD?
    var accessToken: String?
    @IBOutlet weak var imageDato: UIImageView!
    //@IBOutlet weak var name: UITextField!
    @IBOutlet weak var btnNext: MDCButton!
    
    @IBOutlet weak var stackfield: UIStackView!
    let name = MDCOutlinedTextField()
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.setTitle("Siguiente", for: .normal)
        btnNext.setTitleColor(.white, for: .normal)
        btnNext.backgroundColor = .systemBlue
        btnNext.sizeToFit()
        btnNext.layer.cornerRadius = 18
        
        name.label.text = "Nombre"
        name.font = UIFont.init(name: "Trebuchet MS", size: 17)
        name.placeholder = "Fulanito"
        name.leadingAssistiveLabel.text = "Ingrese aqui su nombre."
        name.leadingAssistiveLabel.font = UIFont.init(name: "Trebuchet MS", size: 12)
        name.sizeToFit()
        name.setOutlineColor(.systemBlue, for: .normal)
        name.setOutlineColor(.blue, for: .editing)
        
        stackfield.addArrangedSubview(name)
        stackfield.addArrangedSubview(btnNext)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "quiero" {
            if let nexviewcontroller  = segue.destination as? QuieroViewController {
                nexviewcontroller.accesstoken = self.accessToken
            }
        }
    }
    
    @IBAction func sendDataName(_ sender: Any) {
        if let name = self.name.text, name.trimmed.count > 0{
            self.input_name(accessToken: self.accessToken!,name: name)
        }else{
            showError("Rellene el campo")
        }
    }
    
    func input_name(accessToken:String, name: String ) {
        let BASEURL = "https://phoebe.roshka.com/eat"
        var urlComponents = URLComponents(string: "\(BASEURL)/input_name")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "accessToken", value: accessToken),
            URLQueryItem(name: "name", value: name),
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
                    print("# Success")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "quiero", sender: self.accessToken)
                    }
                }
            }
        }.resume()
    }
}
