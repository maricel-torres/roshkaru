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
        
    }
    
    @objc func verifyNumber(_ sender: UIButton){
        if let codigo = codigoVerificacion.text {
            self.input_sms(accessToken: accessToken!, input: codigo.sha1())
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
            self.codigoVerificacion.text = nil
            showError("Por favor ingrese el codigo")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "datos" {
            if let nextViewController = segue.destination as? DatosViewController {
                nextViewController.sender = self.accessToken
            }
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
            DispatchQueue.main.async {
                self.hud?.hide(animated: true)
            }
            if let error = error {
                print(error)
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
                        // ir al segue de datos
                        self.accessToken = ret.session.accessToken
                        self.challenge = ret.login.challenge
                        self.performSegue(withIdentifier: "datos", sender: nil)
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
