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


class ValidacionViewController: UIViewController {

    @IBOutlet weak var botonVerificar: UIButton!
    @IBOutlet weak var codigoVerificacion: UITextField!
    
    // Variable que contendra el valor ingresado en el texfield
    var codigoIngresado: String?

    var jsonVcLogin: String?
    // Variable que contendra el codigo que se envio al numero celular ingresado
    var challenge: String?
    var accessToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        botonVerificar.addTarget(self, action: #selector(verificarCodigo(_: )), for: .touchUpInside)
        codigoIngresado = codigoVerificacion.text!.sha1()
        accessToken = GetAccessToken()
        //input_sms(accessToken: accessToken!, input: codigoIngresado!)

    }
    
    func GetAccessToken() -> String? {
         UserDefaults.standard.value(forKey: "accessToken") as? String
     }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "datos" {
            if let nextViewController = segue.destination as? DatosViewController {
                nextViewController.sender = self.accessToken
            }
        }
    }
    
    @objc func verificarCodigo(_ sender: UIButton){
        if codigoIngresado == self.challenge {
//            si el sha1 del codigo ingresado es igual al del enviado por mensaje
            performSegue(withIdentifier: "datos", sender: sender)
        }else{
//            sino recarga el view
            showError("Codigo incorrecto")
            self.view.reloadInputViews()
        }
    }
    
    func input_sms(accessToken:String, input: String ) {
        let BASEURL = "https://texo.thebirdmaker.com/eat"
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
            if let error = error {
                print(error);
            } else if let data = data {
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                if let json = json {
                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                } else {
                    print("# Success")
                }
                
                
            }
        }.resume()
        
    }
    
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

