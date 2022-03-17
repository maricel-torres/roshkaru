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
    
    var accessToken:String?
    var challenge:String?
    //@IBOutlet weak var NumeroCelular: UITextField!
    @IBOutlet weak var BtnSendNumber: MDCButton!
    
    @IBOutlet weak var StackLogin: UIStackView!
    let NumeroCelular = MDCOutlinedTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        BtnSendNumber.addTarget(self, action: #selector(SendNumber(_:)), for: .touchUpInside)
        BtnSendNumber.accessibilityLabel = "Create"
        BtnSendNumber.setTitle("ENVIAR", for: .normal)
        BtnSendNumber.setTitleColor(.white, for: .normal)
        BtnSendNumber.backgroundColor = .systemRed
        BtnSendNumber.layer.cornerRadius = 18
        
        
        NumeroCelular.label.text = "Número de teléfono"
        NumeroCelular.placeholder = "09X123456"
        NumeroCelular.leadingAssistiveLabel.text = "Sin letras, guiones o espacios."
        NumeroCelular.sizeToFit()
        NumeroCelular.setOutlineColor(.systemRed, for: .normal)
        NumeroCelular.setOutlineColor(.red, for: .editing)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "IDverificacion"{
            if let nexviewcontroller  = segue.destination as? ValidacionViewController {
                nexviewcontroller.accessToken = self.accessToken
                nexviewcontroller.challenge = self.challenge
            }
        }
    }


    private func start_login(phoneNumber: String, accessToken:String? ) {
        let BASEURL = "https://phoebe.roshka.com/eat"
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
            DispatchQueue.main.async {
                self.hud?.hide(animated: true)
            }
            if let error = error {
                print(error);
            } else if let data = data {
                let httpResponse = response as? HTTPURLResponse
                let status = httpResponse?.statusCode ?? 0
                let statusCodeIsError = status > 299 || status < 200
                
                printDebugJson(data)
                
                if let ret: StartLoginRet = DecodableFromJson(data) {
                    
                    // guardar el access token en defaults
                    UserDefaults.standard.setValue(ret.session.accessToken, forKey: "accessToken")
                    UserDefaults.standard.synchronize()
                    
                    DispatchQueue.main.async {
                        // ir al segue de verificacion
                        self.accessToken = ret.session.accessToken
                        self.challenge = ret.login.challenge
                        self.performSegue(withIdentifier: "IDverificacion", sender: nil)
                    }

                } else if let error: ErrorRet = DecodableFromJson(data) {
                    DispatchQueue.main.async {
                        // mostrar error
                        self.showError(error.userMsg ?? error.msg ?? "Ocurrió un error!")
                    }
                } else if statusCodeIsError {
                    assert(false)
                }
                
            }
        }.resume()
        
    }

}

struct ErrorRet: Codable {
    let errorCode: String?
    let userMsg: String?
    let msg: String?
    let actions: String?
}

func GetAccessToken() -> String? {
    UserDefaults.standard.value(forKey: "accessToken") as? String
}

func printDebugJson(_ jsonData: Data ) {
    if let json = try? JSONSerialization.jsonObject(with: jsonData, options: [.fragmentsAllowed]),
       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]),
       let str = String(data: jsonData, encoding: .utf8) {
        print(str)
    }
}

func DecodableFromJson<T: Decodable>(_ data: Data) -> T? {
    return try? JSONDecoder().decode(T.self, from: data)
}

struct StartLoginRet: Codable {
    struct Session: Codable {
    
        let key1: String // " : "ee5874fb-706e-4cfc-8afb-33b6d4067418",
        let new: Bool // " : true,
        let accessToken: String // " : "ee5874fb-706e-4cfc-8afb-33b6d4067418",
        let key2: String? // " : null,
        let table: String // " : "session",
        let userKey: String? // " : null
        
    }
    struct Login: Codable {
        let challenge: String // " : "011c945f30ce2cbafc452f39840f025693339c42",
        let key1: String // " : "ee5874fb-706e-4cfc-8afb-33b6d4067418",
        let key2: String? // " : null,
        let table: String // " : "login1",
        let phoneNumber: String // " : "+595971305003"
    }
    let session: Session
    let login: Login
    
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

