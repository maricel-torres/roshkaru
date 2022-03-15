//
//  CargaTarjetaTableViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

class CargaTarjetaTableViewController: UIViewController {

    @IBOutlet weak var cargaTarjetaSiguiente: UIButton!
    
    var stackStack = UIStackView()
    var labelNombreTarjeta = UILabel()
    var fieldNombreTarjeta = UITextField()
    var labelNumeroTarjeta = UILabel()
    var fieldNumeroTarjeta = UITextField()
    var labelMesVencimientoTarjeta = UILabel()
    var fieldMesVencimientoTarjeta = UITextField()
    var labelAnhoVencimientoTarjeta = UILabel()
    var fieldAnhoVencimientoTarjeta = UITextField()
    var labelCSCTarjeta = UILabel()
    var fieldCSCTarjeta = UITextField()
    var labelInfo = UILabel()
    var bandaTarjetas = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelInstruccion()
        bandaMarcas()
        stack()
        estiloBoton()
    }
    
    func labelInstruccion () {
        view.addSubview(labelInfo)
        labelInfo.text = "Ingrese los datos de su tarjeta"
        labelInfo.font = labelInfo.font.withSize(25)
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        labelInfo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        labelInfo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    func bandaMarcas () {
        view.addSubview(bandaTarjetas)
        bandaTarjetas.image = UIImage(named: "banda tarjetas")
        bandaTarjetas.translatesAutoresizingMaskIntoConstraints = false
        bandaTarjetas.topAnchor.constraint(equalTo: self.labelInfo.bottomAnchor, constant: 10).isActive = true
        bandaTarjetas.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bandaTarjetas.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bandaTarjetas.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true

    }
    
    //crecion y constraints del stack
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
        //stackStack.spacing = 5
        
        nombreLabel()
       // stackStack.setCustomSpacing(2.0, after: labelNombreTarjeta)
        nombreField()
        numeroLabel()
        //stackStack.setCustomSpacing(2.0, after: labelNumeroTarjeta)
        numeroField()
        anhoLabel()
        //stackStack.setCustomSpacing(2.0, after: labelAnhoVencimientoTarjeta)
        anhoField()
        mesLabel()
       // stackStack.setCustomSpacing(2.0, after: labelMesVencimientoTarjeta)
        mesField()
        cscLabel()
        //stackStack.setCustomSpacing(2.0, after: labelCSCTarjeta)
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
        fieldNombreTarjeta.layer.cornerRadius = 5
        
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
        fieldNumeroTarjeta.layer.cornerRadius = 5
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
        fieldMesVencimientoTarjeta.layer.cornerRadius = 5
        stackStack.addArrangedSubview(fieldMesVencimientoTarjeta)
    }
    
    //label anho vencimiento de tarjeta
    func anhoLabel () {
        labelAnhoVencimientoTarjeta.text = "Año de vencimiento"
        stackStack.addArrangedSubview(labelAnhoVencimientoTarjeta)
    }
    
    //field anho vencimiento de tarjeta
    func anhoField () {
        fieldAnhoVencimientoTarjeta.placeholder = "AA"
        fieldAnhoVencimientoTarjeta.layer.borderWidth = 0.5
        fieldAnhoVencimientoTarjeta.layer.cornerRadius = 5
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
        fieldCSCTarjeta.layer.cornerRadius = 5
        stackStack.addArrangedSubview(fieldCSCTarjeta)
    }
    

    //estilo y ubicacion del boton 'siguiente'
    func estiloBoton () {
       
        cargaTarjetaSiguiente.translatesAutoresizingMaskIntoConstraints = false
        cargaTarjetaSiguiente.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cargaTarjetaSiguiente.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
        cargaTarjetaSiguiente.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        cargaTarjetaSiguiente.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        cargaTarjetaSiguiente.backgroundColor = .systemBlue
        cargaTarjetaSiguiente.setTitleColor(.white, for: .normal)
        cargaTarjetaSiguiente.layer.cornerRadius = 5
        //allowResize?.isActive = true
        //cargaTarjetaSiguiente.frame.size.height = 100
    }
    



}
