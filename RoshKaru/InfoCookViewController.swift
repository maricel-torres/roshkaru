//
//  InfoCookViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/21/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit


class InfoCookViewController: UIViewController {
    
    var historyStack = UIStackView()
    var nombreTitulo = UILabel()
    var historyImg = UIImageView()
    var textLabel = UILabel()
    var accessToken: String?
    var nombreCook: String?
    var imagenURL: String!
    var descripcionCook: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .init(displayP3Red: 253, green: 237, blue: 236, alpha: 1.0)
        crearStack()
        
    }
    
    
    
    //funcion para setear stack
    func crearStack () {
        view.addSubview(historyStack)
        historyStack.translatesAutoresizingMaskIntoConstraints = false
        historyStack.centerYAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        historyStack.centerXAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        historyStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        historyStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        historyStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        historyStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        historyStack.axis = .vertical
        historyStack.alignment = .center
        historyStack.distribution = .fillEqually
        historyStack.spacing = 10
        
        tituloHistory()
        imgImg()
        parrafo()
        
    }

    //funcion seteo del titulo en stack
    func tituloHistory () {
        historyStack.addArrangedSubview(nombreTitulo)
        nombreTitulo.text = nombreCook
        nombreTitulo.font = nombreTitulo.font.withSize(30)
    }
    
    //seteo de la imagen en el stack
    func imgImg () {
        historyStack.addArrangedSubview(historyImg)
        //historyImg.image?.size.height = 50
        let imgurl = imagenURL
        if let url = URL(string: imgurl ?? "https://adaziodesign.com/wp-content/uploads/2021/03/shche_-team-0dszrg9-V1o-unsplash-1200x1200.jpg") {
            do {
                let data = try Data(contentsOf: url)
                historyImg.image = UIImage(data: data)
            } catch let err {
                print("Error: \(err.localizedDescription)")
            }
        }
        
        
    }
    
    //seteo del parrafo en el stack
    func parrafo () {
        historyStack.addArrangedSubview(textLabel)
        textLabel.text = descripcionCook
        textLabel.font = textLabel.font.withSize(20)
        textLabel.numberOfLines = 0
    }
    
}



