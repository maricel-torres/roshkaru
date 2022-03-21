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

        crearStack()
        // Do any additional setup after loading the view.
    }
    
    
    
    //funcion para setear stack
    func crearStack () {
        view.addSubview(historyStack)
        historyStack.translatesAutoresizingMaskIntoConstraints = false
        historyStack.centerYAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        historyStack.centerXAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        historyStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        historyStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        historyStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        historyStack.axis = .vertical
        historyStack.alignment = .center
        historyStack.distribution = .fillEqually
        historyStack.spacing = 20
        
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
        //self.historyImg.downloadImage(from: URL(string: imagenURL!)!)
    }
    
    //seteo del parrafo en el stack
    func parrafo () {
        historyStack.addArrangedSubview(textLabel)
        textLabel.text = descripcionCook
        textLabel.font = textLabel.font.withSize(20)
        textLabel.numberOfLines = 0
    }
    
}



//extension para obtener la imagen desde url
extension UIImageView {
    func getData(from imageURL: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
       URLSession.shared.dataTask(with: imageURL, completionHandler: completion).resume()
    }
    func downloadImage(from imageURL: URL) {
       getData(from: imageURL) {
          data, response, error in
          guard let data = data, error == nil else {
             return
          }
          DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
       }
    }
}


