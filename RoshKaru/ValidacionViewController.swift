//
//  ValidacionViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import CommonCrypto
import CryptoKit


class ValidacionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var verifyImage: UIImageView!
    @IBOutlet weak var botonVerificar: MDCButton!
    
    @IBOutlet weak var Stackfield: UIStackView!
    let codeNumber = MDCOutlinedTextField()    // Variable que contendra el valor ingresado en el texfield
    var codigoIngresado: String?

    var jsonVcLogin: String?
    // Variable que contendra el codigo que se envio al numero celular ingresado
    var challenge: String?
    var accessToken: String? 
        
    override func viewDidLoad() {
        super.viewDidLoad()
        codeNumber.delegate = self
        codeNumber.keyboardType = .numberPad
        
        botonVerificar.setTitle("VERIFICAR", for: .normal)
        botonVerificar.setTitleColor(.white, for: .normal)
        botonVerificar.backgroundColor = .systemBlue
        botonVerificar.sizeToFit()
        botonVerificar.layer.cornerRadius = 18
            
            
        codeNumber.label.text = "Código"
        codeNumber.font = UIFont.init(name: "Trebuchet MS", size: 17)

        codeNumber.placeholder = "Ingrese aquí su código"
        

        codeNumber.leadingAssistiveLabel.text = "Sin letras, guiones o espacios."
        codeNumber.leadingAssistiveLabel.font = UIFont.init(name: "Trebuchet MS", size: 12)
        codeNumber.sizeToFit()
        codeNumber.setOutlineColor(.systemBlue, for: .normal)
        codeNumber.setOutlineColor(.blue, for: .editing)
            
        Stackfield.addArrangedSubview(codeNumber)
        Stackfield.addArrangedSubview(botonVerificar)
    }
    
    // funcion para poder ingresar solo numeros en el textfiel
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowChar = "0123456789"
        let allowCharSet = CharacterSet(charactersIn: allowChar)
        let typeCharSet = CharacterSet(charactersIn: string)
        return allowCharSet.isSuperset(of: typeCharSet)
    }
    
    
    @IBAction func verifyCode(_ sender: Any) {
        if codeNumber.text == "1111" {
            if let codeCelular = codeNumber.text {
                self.input_sms(accessToken: accessToken!, input: codeCelular.sha1())
            }
        }
        else{
            showError("Código de verificación incorrecto")
        }
        
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        makeCall()
        return false
    }

    private var hud: MBProgressHUD?
    
    private func makeCall() {
        
        let x: UITextField? = findFirst(self.view)
        if let code = x?.text, code.trimmed.count > 0 {
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
           hud?.hide(animated: true, afterDelay: 2)
        } else {
            self.codeNumber.text = nil
            showError("Por favor ingrese el codigo")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "datos" {
            if let nextViewController = segue.destination as? DatosViewController {
                nextViewController.accessToken = self.accessToken
            }
        }
    }
    
    
    func input_sms(accessToken:String, input: String ) {
        let BASEURL = "https://phoebe.roshka.com/eat"
        var urlComponents = URLComponents(string: "\(BASEURL)/input_sms")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "accessToken", value: accessToken),
            URLQueryItem(name: "input", value: input),
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
                        self.performSegue(withIdentifier: "datos", sender: accessToken)
                     }
                }
            }
        }.resume()
    }
    
    
    
//    func input_sms(accessToken:String, input: String ) {
//        let BASEURL = "https://phoebe.roshka.com/eat"
//        var urlComponents = URLComponents(string: "\(BASEURL)/input_sms")!
//        let queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "accessToken", value: accessToken),
//            URLQueryItem(name: "input", value: input),
//        ]
//        urlComponents.queryItems = queryItems
//        let url = urlComponents.url!
//        print(url.absoluteString)
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                self.hud?.hide(animated: true)
//            }
//            if let error = error {
//                print(error)
//            } else if let data = data {
//                printDebugJson(data)
//                DispatchQueue.main.async {
//                    self.performSegue(withIdentifier: "datos", sender: accessToken)
//                 }
//            }
//        }.resume()
//
//    }
    
}
// Extension para obtener el Sha1 de un string
extension String {
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}
