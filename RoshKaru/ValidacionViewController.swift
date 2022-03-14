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

private extension UIColor {
    static var firstColor: UIColor = .cyan
    static var secondColor: UIColor = .white
    
//    static var firstColor: UIColor = .black
//    static var secondColor: UIColor = .cyan
    
//    static var firstColor: UIColor = .orange
//    static var secondColor: UIColor = .black
    
//    static var firstColor: UIColor = .green
//    static var secondColor: UIColor = .black
    
//    static var firstColor: UIColor = .black
//    static var secondColor: UIColor = .green
}

class ValidacionViewController: UIViewController {

    @IBOutlet weak var botonVerificar: UIButton!
    @IBOutlet weak var codigoVerificacion: UITextField!
    // Variable que contendra el codigo que se envio al numero celular ingresado
    var codigo : String?
    // Variable que contendra el valor ingresado en el texfield
    var jsonVcLogin : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .firstColor
        botonVerificar.backgroundColor = .secondColor
        botonVerificar.addTarget(self, action: #selector(verificarCodigo(_: )), for: .touchUpInside)
        codigo = codigoVerificacion.text!

    }
    
    @objc func verificarCodigo(_ sender: UIButton){
//        if codigoIngresado?.sha1() == codigo{
//            performSegue(withIdentifier: "datos", sender: sender)
//        }else{
//            print("codigo incorrecto!")
//            self.viewDidLoad()
//        }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
