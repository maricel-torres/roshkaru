//
//  DireccionViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import MBProgressHUD
import MaterialComponents.MaterialButtons

/// Pods materialComponets
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class DireccionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewPricipal: UIStackView!
    @IBOutlet weak var streetName: MDCOutlinedTextField!
    @IBOutlet weak var number: MDCOutlinedTextField!
    @IBOutlet weak var neighborhood: MDCOutlinedTextField!
    @IBOutlet weak var reference: MDCOutlinedTextField!
    @IBOutlet weak var button: MDCButton!
    
    var accessToken:String?
    private var hud: MBProgressHUD?
    
    override func viewDidLoad() {
        self.title = "Agregar Dirección"
        super.viewDidLoad()
        stackViewPricipal.spacing = 20
        stackView.spacing = 10
        
        button.accessibilityLabel = "Create"
        button.setTitle("Siguiente", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 18
        
        number.label.text = "Número de Domicilio"
        number.delegate = self
        number.keyboardType = .numberPad
        number.font = UIFont.init(name: "Trebuchet MS", size: 17)
        number.placeholder = "Nro. Domicilio"
        number.sizeToFit()
        number.setOutlineColor(.systemBlue, for: .normal)
        number.setOutlineColor(.blue, for: .editing)
        
        streetName.label.text = "Nombre de Calle"
        streetName.font = UIFont.init(name: "Trebuchet MS", size: 17)
        streetName.placeholder = "Calle"
        streetName.sizeToFit()
        streetName.setOutlineColor(.systemBlue, for: .normal)
        streetName.setOutlineColor(.blue, for: .editing)
        
        neighborhood.label.text = "Barrio"
        neighborhood.font = UIFont.init(name: "Trebuchet MS", size: 17)
        neighborhood.placeholder = "Barrio"
        neighborhood.sizeToFit()
        neighborhood.setOutlineColor(.systemBlue, for: .normal)
        neighborhood.setOutlineColor(.blue, for: .editing)
        
        reference.label.text = "Referencias (Opcional)"
        reference.font = UIFont.init(name: "Trebuchet MS", size: 17)
        reference.placeholder = "Referencias"
        reference.sizeToFit()
        reference.setOutlineColor(.systemBlue, for: .normal)
        reference.setOutlineColor(.blue, for: .editing)
        
    }
    // MARK: - Navigation

    @IBAction func sendData(_ sender: Any) {
        if let streetName = self.streetName.text, streetName.trimmed.count > 0,
           let number = self.number.text, number.trimmed.count > 0,
           let neighborhood = self.neighborhood.text, neighborhood.trimmed.count > 0 {
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.set_address(accessToken: self.accessToken!,
                                 addressType: .delivery,
                                 streetName: self.streetName.text!,
                                 number: self.number.text!,
                                 neighborhood: self.neighborhood.text!,
                                 reference: self.reference.text)
        }
        else{
            showError("Rellene campos faltantes")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "principal" {
            if let nextViewController = segue.destination as? PrincipalTableViewController {
                nextViewController.accessToken = self.accessToken
            }
        }
    }
    
    
    enum AddressType: String {
        case delivery, cook_site
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowChar = "0123456789"
        let allowCharSet = CharacterSet(charactersIn: allowChar)
        let typeCharSet = CharacterSet(charactersIn: string)
        return allowCharSet.isSuperset(of: typeCharSet)
    }

    func set_address(accessToken: String, addressType:AddressType, streetName:String, number:String, neighborhood:String, reference:String?) {
        let BASEURL = "https://phoebe.roshka.com/eat"
        var urlComponents = URLComponents(string: "\(BASEURL)/set_address")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "addressType", value: addressType.rawValue),
            URLQueryItem(name: "streetName", value: streetName),
            URLQueryItem(name: "number", value: number),
            URLQueryItem(name: "neighborhood", value: neighborhood),
            URLQueryItem(name: "accessToken", value: accessToken),
            URLQueryItem(name: "replace", value: String(true)),
        ]
        if let reference = reference {
            queryItems.append(URLQueryItem(name: "reference", value: reference))
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
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                if let json = json {
                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                } else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "principal", sender: self.accessToken!)
                    }
                    print("# Success")
                }
                
                
            }
        }.resume()
        
    }
    
}
