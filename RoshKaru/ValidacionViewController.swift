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
    // Variable que contendra el codigo que se envio al numero celular ingresado
    var codigoIngresado: String?
    // Variable que contendra el valor ingresado en el texfield
    var codigo: String?
    var jsonVcLogin: String?
    var jsonLogin: ItemJson?
    var accessToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accessToken = "3rwr345r43tret5654y6egret65hn"

        codigo = jsonLogin?.challenge
        
        botonVerificar.addTarget(self, action: #selector(verificarCodigo(_: )), for: .touchUpInside)
        codigoIngresado = codigoVerificacion.text!
        

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
        if codigoIngresado?.sha1() == codigo {
//            si el sha1 del codigo ingresado es igual al del enviado por mensaje
            performSegue(withIdentifier: "datos", sender: sender)
        }else{
//            sino recarga el view
            print("codigo incorrecto!")
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
    
    // Estructura creada para decodificar
    struct ItemJson: Codable {
        var challenge: String?
        var key1: String?
        var key2: Int?
        var table: String?
        var phoneNumber: String?
    }
    
    
    private func json2(_ string:String) -> [ItemJson] {
        let jsonString = string
        let listaJson = try? JSONDecoder().decode([ItemJson].self, from: jsonString.data(using: .utf8)!)
        
        if let listaJson = listaJson {
            return listaJson
        }else{
            return []
        }
        
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
