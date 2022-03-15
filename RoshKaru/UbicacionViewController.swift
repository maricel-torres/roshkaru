//
//  UbicacionViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import MapKit

class UbicacionViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttomSgte: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let noLocation = CLLocationCoordinate2DMake(-25.281818845574698, -57.61052921667962)
        let viewRegion = MKCoordinateRegion(center: noLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(viewRegion, animated: true)
        
        
        //stackView.spacing = 20
        
    }
    
    
//    func setPinUsingMKPointAnnotation(ubicación: CLLocationCoordinate2D){
//       let anotación = MKPointAnnotation()
//       anotación.coordinada = ubicación
//       anotación.título = "Aquí"
//       anotación.subtítulo = "Ubicación del dispositivo"
//       let coordinaRegión = MKCoordinateRegion(centro: anotación.coordinada, latitudinalMeters: 800, longitudinalMeters : 800)
//       mapView.setRegion(coordinateRegion, animado: verdadero)
//       mapView.addAnnotation(anotación)
//    }
    

    // MARK: - Navigation


}
