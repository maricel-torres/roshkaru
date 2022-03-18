//
//  InfoCookViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/18/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

class InfoCookViewController: UIViewController {
    
    var nombreLabel = UILabel()
    var imgView = UIImageView()
    var detalleLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitulo()
        setImg()
        setDetalle()
    }

    //seteo del label titulo
    func setTitulo () {
        view.addSubview(nombreLabel)
        nombreLabel.translatesAutoresizingMaskIntoConstraints = false
        nombreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        nombreLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        nombreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        nombreLabel.text = "Chefsito"
        
    }
    
    //seteo de la imagen
    func setImg () {
        view.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: nombreLabel.safeAreaLayoutGuide.bottomAnchor, constant: 30).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        imgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
    }
    
    //seteo de la descripcion
    func setDetalle () {
        view.addSubview(detalleLabel)
        detalleLabel.translatesAutoresizingMaskIntoConstraints = false
        detalleLabel.topAnchor.constraint(equalTo: imgView.safeAreaLayoutGuide.bottomAnchor, constant: 30).isActive = true
        detalleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        detalleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        detalleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ut velit vel odio porttitor malesuada et sed justo. Aenean laoreet neque quis ipsum tristique feugiat sed vitae ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam sed congue lorem. Sed malesuada magna in accumsan eleifend. In eget ullamcorper metus. Etiam laoreet consequat erat, id feugiat augue mattis vitae. Curabitur sodales finibus magna vitae facilisis. Suspendisse cursus viverra placerat."
        
    }
    
    
    
}
