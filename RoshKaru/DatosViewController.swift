//
//  DatosViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import MBProgressHUD

class DatosViewController: UIViewController {
    
    var accessToken: String?
    @IBOutlet weak var imageDato: UIImageView!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageDato.image = UIImage(named: "name")
        
        btnNext.setTitle("Siguiente", for: .normal)
        btnNext.setTitleColor(.white, for: .normal)
        btnNext.backgroundColor = .systemRed
        btnNext.sizeToFit()
        btnNext.layer.cornerRadius = 18

    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        makeCall()
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "registrar"{
            if let nexviewcontroller  = segue.destination as? UbicacionViewController {
                nexviewcontroller.accessToken = self.accessToken
            }
        }
    }
    
    private var hud: MBProgressHUD?
    
    private func makeCall() {
        
        let x: UITextField? = findFirst(self.view)
        if let dato = x?.text, dato.trimmed.count > 0 {
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            input_name(accessToken: accessToken!, name: name.text!)
        } else {
            showError("Por favor ingrese nombre")
            self.name.text = nil
        }
        
    }

    @IBAction func sendName(_ sender: Any) {
        //self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.input_name(accessToken: self.accessToken!,
                        name: name.text!)

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
            }else if let data = data {
                let httpResponse = response as? HTTPURLResponse
                let status = httpResponse?.statusCode ?? 0
                let statusCodeIsError = status < 200 || status > 299
                
                printDebugJson(data)
                DispatchQueue.main.async {
                     // ir al segue de registrar
                    self.performSegue(withIdentifier: "registrar", sender: accessToken)
                 }
                
                if let ret: StartLoginRet = DecodableFromJson(data) {
                    
                    // guardar el access token en defaults
                    UserDefaults.standard.setValue(ret.session.accessToken, forKey: "accessToken")
                    UserDefaults.standard.synchronize()

                } else if let error: ErrorRet = DecodableFromJson(data) {
                    DispatchQueue.main.async {
                        // mostrar error
                        self.showError(error.userMsg ?? error.msg ?? "Ocurrió un error!")
                        self.name.text = nil
                    }
                }
                
            }
        }.resume()
        
    }
}
