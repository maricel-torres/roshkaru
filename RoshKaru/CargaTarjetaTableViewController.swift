//
//  CargaTarjetaTableViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import MBProgressHUD
import TextFieldFormatter
class CargaTarjetaTableViewController: UIViewController {

    @IBOutlet weak var cargaTarjetaSiguiente: UIButton!
    
    //elementos
    var stackStack = UIStackView()
    var labelNombreTarjeta = UILabel()
    var fieldNombreTarjeta = UITextField()
    var labelNumeroTarjeta = UILabel()
    var fieldNumeroTarjeta = TextFieldFormatter()
    var labelMesVencimientoTarjeta = UILabel()
    var fieldMesVencimientoTarjeta = TextFieldFormatter()
    var labelAnhoVencimientoTarjeta = UILabel()
    var fieldAnhoVencimientoTarjeta = TextFieldFormatter()
    var labelCSCTarjeta = UILabel()
    var fieldCSCTarjeta = TextFieldFormatter()
    var labelInfo = UILabel()
    var bandaTarjetas = UIImageView()
    var bottomLine = CALayer()
    
    
    private var hud: MBProgressHUD?
    var accessToken: String?
    var paymentType: PaymentType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelInstruccion()
        stack()
        estiloBoton()
        //self.accessToken = "754699cb-27b5-4b4b-8fcf-9079b95bf23f"
        
        fieldNumeroTarjeta.pattern = "NNNN-NNNN-NNNN-NNNN"
        fieldAnhoVencimientoTarjeta.pattern = "NNNN"
        fieldMesVencimientoTarjeta.pattern = "NN"
        fieldCSCTarjeta.pattern = "NNN"
        
    }
    
    //MBProgressHUD para animacion de "cargando"
    @IBAction func buttonAction(_ sender: Any) {
    
        //verifica si hay campos vacios
        if fieldNombreTarjeta.text! == "" || fieldNumeroTarjeta.text! == "" || fieldAnhoVencimientoTarjeta.text! == "" || fieldMesVencimientoTarjeta.text! == "" || fieldCSCTarjeta.text! == ""{
           let alert = UIAlertController(title: "El hambre hace efecto!", message: "Verifica datos incorrectos o campos vacios.", preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
           present(alert, animated: true)
        } else  {
        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.add_payment_method(accessToken: self.accessToken!,
                                type: .credit_card,
                                cardHolderName: fieldNombreTarjeta.text,
                                cardNumbers: fieldNumeroTarjeta.text,
                                cardExpirationMonth: Int(fieldMesVencimientoTarjeta.text!),
                                cardExpirationYear: Int(fieldAnhoVencimientoTarjeta.text!),
                                cardSecurityCode: fieldCSCTarjeta.text)
        }
    }

    
    //label titulo del screen
    func labelInstruccion () {
        view.addSubview(labelInfo)
        labelInfo.text = "Ingrese los datos de su tarjeta"
        labelInfo.font = labelInfo.font.withSize(25)
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        labelInfo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        labelInfo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    //funcion para la imagen
    func bandaMarcas () {
        view.addSubview(bandaTarjetas)
        bandaTarjetas.image = UIImage(named: "banda tarjetas")
        bandaTarjetas.translatesAutoresizingMaskIntoConstraints = false
        //bandaTarjetas.topAnchor.constraint(equalTo: self.labelInfo.bottomAnchor, constant: 10).isActive = true
        bandaTarjetas.bottomAnchor.constraint(equalTo: self.stackStack.topAnchor, constant: -20).isActive = true
        bandaTarjetas.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bandaTarjetas.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bandaTarjetas.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true

    }
    
    //crecion del stack, constraints del stack y adicion de elementos
    func stack () {
        view.addSubview(stackStack)
        stackStack.translatesAutoresizingMaskIntoConstraints = false
        //stackStack.topAnchor.constraint(equalTo: self.bandaTarjetas.bottomAnchor, constant: 20).isActive = true
        stackStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        stackStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        //stackStack.bottomAnchor.constraint(equalTo: self.cargaTarjetaSiguiente.topAnchor, constant: -100).isActive = true
        
        stackStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackStack.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        
        stackStack.axis = .vertical
        stackStack.distribution = .fillEqually
        
        bandaMarcas()
        nombreLabel()
        nombreField()
        numeroLabel()
        numeroField()
        anhoLabel()
        anhoField()
        mesLabel()
        mesField()
        cscLabel()
        cscField()
    }
    
    //lanel nombre tarjeta
    func nombreLabel () {
        labelNombreTarjeta.text = "Nombre del propietario"
        stackStack.addArrangedSubview(labelNombreTarjeta)
    }
    
    //field nombre tarjeta
    func nombreField () {
        fieldNombreTarjeta.placeholder = "Nombre"
        fieldNombreTarjeta.layer.borderWidth = 0.5
        fieldNombreTarjeta.layer.cornerRadius = 4
        fieldNombreTarjeta.layer.borderColor = UIColor.gray.cgColor
        stackStack.addArrangedSubview(fieldNombreTarjeta)
    }
    
    //label numero tarjeta
    func numeroLabel () {
        labelNumeroTarjeta.text = "Numero de tarjeta"
        stackStack.addArrangedSubview(labelNumeroTarjeta)
    }
    
    //field numero tarjeta
    func numeroField () {
        fieldNumeroTarjeta.placeholder = "XXXX-XXXX-XXXX-XXXX"
        fieldNumeroTarjeta.layer.borderWidth = 0.5
        fieldNumeroTarjeta.layer.cornerRadius = 4
        fieldNumeroTarjeta.layer.borderColor = UIColor.gray.cgColor
        stackStack.addArrangedSubview(fieldNumeroTarjeta)
    }
    
    //label mes vencimiento de tarjeta
    func mesLabel () {
        labelMesVencimientoTarjeta.text = "Mes de vencimiento"
        stackStack.addArrangedSubview(labelMesVencimientoTarjeta)
    }
    
    //field mes vencimiento de tarjeta
    func mesField () {
        fieldMesVencimientoTarjeta.placeholder = "MM"
        fieldMesVencimientoTarjeta.layer.borderWidth = 0.5
        fieldMesVencimientoTarjeta.layer.cornerRadius = 4
        fieldMesVencimientoTarjeta.layer.borderColor = UIColor.gray.cgColor
        stackStack.addArrangedSubview(fieldMesVencimientoTarjeta)
    }
    
    //label anho vencimiento de tarjeta
    func anhoLabel () {
        labelAnhoVencimientoTarjeta.text = "Año de vencimiento"
        stackStack.addArrangedSubview(labelAnhoVencimientoTarjeta)
    }
    
    //field anho vencimiento de tarjeta
    func anhoField () {
        fieldAnhoVencimientoTarjeta.placeholder = "AAAA"
        fieldAnhoVencimientoTarjeta.layer.borderWidth = 0.5
        fieldAnhoVencimientoTarjeta.layer.cornerRadius = 4
        fieldAnhoVencimientoTarjeta.layer.borderColor = UIColor.gray.cgColor
        stackStack.addArrangedSubview(fieldAnhoVencimientoTarjeta)
    }
    
    //label CSC vencimiento de tarjeta
    func cscLabel () {
        labelCSCTarjeta.text = "Codigo de seguridad"
        stackStack.addArrangedSubview(labelCSCTarjeta)
    }
    
    //field CSC vencimiento de tarjeta
    func cscField () {
        fieldCSCTarjeta.placeholder = "XXX"
        fieldCSCTarjeta.layer.borderWidth = 0.5
        fieldCSCTarjeta.layer.cornerRadius = 4
        fieldCSCTarjeta.layer.borderColor = UIColor.gray.cgColor
        stackStack.addArrangedSubview(fieldCSCTarjeta)
    }
    

    //estilo y ubicacion del boton 'siguiente'
    func estiloBoton () {
       
        cargaTarjetaSiguiente.translatesAutoresizingMaskIntoConstraints = false
        cargaTarjetaSiguiente.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cargaTarjetaSiguiente.topAnchor.constraint(equalTo: self.stackStack.bottomAnchor, constant: 80).isActive = true
        cargaTarjetaSiguiente.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        cargaTarjetaSiguiente.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        cargaTarjetaSiguiente.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        cargaTarjetaSiguiente.frame.size.height = 25
        cargaTarjetaSiguiente.backgroundColor = .systemBlue
        cargaTarjetaSiguiente.setTitleColor(.white, for: .normal)
        cargaTarjetaSiguiente.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cargaTarjetaSiguiente.layer.cornerRadius = 22
        cargaTarjetaSiguiente.titleLabel?.text = "GUARDAR"
        
    }
    
    //definicion tipos de datos segun medio de pago
    enum PaymentType: String {
        case credit_card
        case cash
    }
        
    //funcion para agregar datos de tarjeta
    func add_payment_method(accessToken: String,
                                   type:PaymentType,
                                   cardHolderName: String?,
                                   cardNumbers: String?,
                                   cardExpirationMonth: Int?,
                                   cardExpirationYear: Int?,
                                   cardSecurityCode: String?
    ) {
        let BASEURL = "https://phoebe.roshka.com/eat"
        var urlComponents = URLComponents(string: "\(BASEURL)/add_payment_method")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "type", value: type.rawValue),
            URLQueryItem(name: "replace", value: String(true)),
            AccessTokenQueryItem(accessToken)
        ]
        if let cardHolderName = cardHolderName {
            queryItems.append(URLQueryItem(name: "cardHolderName", value: cardHolderName))
        }
        if let cardNumbers = cardNumbers {
            queryItems.append(URLQueryItem(name: "cardNumbers", value: cardNumbers))
        }
        if let cardExpirationMonth = cardExpirationMonth {
            queryItems.append(URLQueryItem(name: "cardExpirationMonth", value: String(cardExpirationMonth)))
        }
        if let cardExpirationYear = cardExpirationYear {
            queryItems.append(URLQueryItem(name: "cardExpirationYear", value: String(cardExpirationYear)))
        }
        if let cardSecurityCode = cardSecurityCode {
            queryItems.append(URLQueryItem(name: "cardSecurityCode", value: cardSecurityCode))
        }
        
        
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
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }.resume()
        
    }
    
    func AccessTokenQueryItem(_ at: String ) -> URLQueryItem {
        URLQueryItem(name: "accessToken", value: at)
    }


}
