//
//  ViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import MBProgressHUD

/// Pods materialComponets
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class LoginViewController: UIViewController {
    var json:String?
    //@IBOutlet weak var NumeroCelular: UITextField!
    @IBOutlet weak var BtnSendNumber: UIButton!
    
    @IBOutlet weak var StackLogin: UIStackView!
    let NumeroCelular = MDCOutlinedTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnSendNumber.addTarget(self, action: #selector(SendNumber(_:)), for: .touchUpInside)
        
        //let estimatedFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
       // let NumeroCelular = MDCOutlinedTextField(frame: estimatedFrame)
        NumeroCelular.label.text = "Phone number"
        NumeroCelular.placeholder = "Ej: 09Xx-XXX-XXX"
        NumeroCelular.leadingAssistiveLabel.text = "This is helper text"
        NumeroCelular.sizeToFit()
        NumeroCelular.setOutlineColor(.systemBlue, for: .normal)
        NumeroCelular.setOutlineColor(.blue, for: .editing)
        
        //view.addSubview(textField)
        StackLogin.addArrangedSubview(NumeroCelular)
        StackLogin.addArrangedSubview(BtnSendNumber)
    }
    
    @IBAction func SendNumber(_ sender: Any) {
        if let nroCelular = NumeroCelular.text {
            self.start_login(phoneNumber: nroCelular, accessToken: nil)
            
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        makeCall()
        return false
    }
    private var hud: MBProgressHUD?
    
    private func makeCall() {
        
        let x: UITextField? = findFirst(self.view)
        if let phone = x?.text, phone.trimmed.count > 0 {
            
            
            
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
           hud?.hide(animated: true, afterDelay: 3)
            // start_login(phoneNumber: phone, accessToken: nil)
        } else {
            showError("Por favor ingrese el número de teléfono")
        }
        
    }
    
    func start_login(phoneNumber: String, accessToken:String? ) {
        let BASEURL = "https://texo.thebirdmaker.com/eat"
        var urlComponents = URLComponents(string: "\(BASEURL)/start_login")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "phoneNumber", value: phoneNumber),
        ]
        if accessToken != nil {
            queryItems.append(URLQueryItem(name: "accessToken", value: accessToken!))
        }
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        print(url.absoluteString)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error);
            } else if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                
                let jsonString = String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!
                
                print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                
                self.json = String(jsonString)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "IDverificacion", sender: self.json)
                }
            }
            
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "IDverificacion"{
            if let nexviewcontroller  = segue.destination as? ValidacionViewController {
                nexviewcontroller.jsonVcLogin = self.json
            }
        }
    }
}
extension String {
 
    var trimmed: String {
        self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
}

extension UIViewController {
    
    func findFirst<T>(_ view: UIView) -> T? {
        for v in view.subviews {
            if let x = v as? T {
                return x
            }
        }
        for v in view.subviews {
            if let x:T = findFirst(v) {
                return x
            }
        }
        return nil
    }
    
    func showError(_ msg: String) {
        let c = UIAlertController(title: nil, message: msg, preferredStyle: .alert);
        c.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            //
        }))
        self.present(c, animated: true, completion: nil)
    }
}

