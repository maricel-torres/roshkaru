//
//  OfertasViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit


struct Item : Codable {
    var day : String
    var title: String
    var price: Int
    var currencyCode: String
    var key: String
    var dayPart: String
    var description: String
}
struct Offer : Codable{
    let key: String
    var items: [Item]
}
struct Cook : Codable{
    var offers: [Offer]
    var kitchenPhotoUrl: String?
    var key: String
    var description: String
    var photoUrl: String
    var name: String
    var kitchen: String
}
var totalAPagar: Int = 0
var totalpedido: Int = 0

class OfertasViewController: UITableViewController {
    var index:Int?
    var total : Int?
    var pedido: Int?
    
    var BASEURL = "https://phoebe.roshka.com/eat"
    var weklyPlans : [Cook]?
    var at = "be73b556-4de1-402b-84b9-0f0a0977b5fb"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        weekly_plans_cooks(accessToken: at)
        //self.tableView.contentInset = .init(top: 0, left: 0, bottom: -50, right: 0)
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .green
//        view.layer.zPosition = 1111
//        self.tableView.addSubview(view)
//        let to = self.tableView!
//        NSLayoutConstraint.activate([
//            view.trailingAnchor.constraint(equalTo: to.trailingAnchor),
//            view.leadingAnchor.constraint(equalTo: to.leadingAnchor),
//            view.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor),
//            view.heightAnchor.constraint(equalToConstant: 100)
//        ])
//        self.tableView.contentInset = .init(top: 0, left: 0, bottom: -200, right: 0)
        
        
       print("total a pagar: \(totalAPagar)")
       print("toatal de pedidos: \(totalpedido)")
        
    }
    public func weekly_plans_cooks (accessToken:String) {
        var urlComponents = URLComponents(string: "\(BASEURL)/weekly_plans/cooks")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "accessToken", value: accessToken)
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
                    //print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                   self.weklyPlans = self.DecodeJson("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("# Success")
                }
            }
        }.resume()
    }
    public func DecodeJson(_ jsonString: String)-> [Cook] {
        let listaJson = try? JSONDecoder().decode([Cook].self, from: jsonString.data(using: .utf8)!)
//        if let listaJson = listaJson {
//            print(listaJson)
//        }
        return listaJson!
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        ""
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
         weklyPlans?[0].offers.count ?? 0
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weklyPlans?[0].offers[section].items.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "items", for: indexPath) as? OfertaCell
        celda?.item = weklyPlans?[0].offers[indexPath.section].items[indexPath.row]
        
         return celda!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        self.performSegue(withIdentifier: "oferta", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if segue.identifier == "oferta" {
                if let nextViewController = segue.destination as? Quantity {
                    nextViewController.datos = weklyPlans![index!]
                    nextViewController.indice = index
                }
            }
        }
}

class OfertaCell: UITableViewCell {
    
    var item : Item? {
        didSet {
            
            diaHora.text = (item?.day ?? "") + "-" + (item?.dayPart ?? "")
            titulo.text = item?.title
            precio.text = "Gs." + String(item?.price ?? 0)
            descripcion.text = "Reseña: " + (item?.description ?? "")
        }
    }
    
    @IBOutlet weak var diaHora: UILabel!
 
    
    @IBOutlet weak var precio: UILabel!
    
    
    @IBOutlet weak var titulo: UILabel!


    @IBOutlet weak var descripcion: UILabel!
    
    
}
class Quantity: UIViewController{

    var datos : Cook?
    var indice : Int?
    var pedido : Int = 0
    var pedidoChanged : Int = 0
    var PagoChanged: Int = 0
    @IBOutlet weak var StackView1: UIStackView!
    
    @IBOutlet weak var StackView2: UIStackView!
    
    @IBOutlet weak var StackView3: UIStackView!
    
    @IBOutlet weak var Titulo: UILabel!
    
    @IBOutlet weak var Precio: UILabel!
    
    @IBOutlet weak var AddButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StackView1.spacing = 30
        StackView2.spacing = 120
        Titulo.text = datos?.offers[indice!].items[indice!].title
        Precio.text = "Gs." + String(datos?.offers[indice!].items[indice!].price ?? 0)
        self.AddButton.setTitle("Agregar a mi pedido Gs. \(String(datos?.offers[indice!].items[indice!].price ?? 0))", for: .normal)
        
        
    }
    
    
    
    @IBAction func StepperValueChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        PagoChanged = value * (datos?.offers[indice!].items[indice!].price ?? 0)
        self.AddButton.setTitle("Agregar a mi pedido Gs. \(String(PagoChanged))", for: .normal)
        pedidoChanged = Int(sender.value)
        //print("PagoChanged: \(PagoChanged), PedidoChanged: \(pedidoChanged)")
        
    }
   
    
    @IBAction func volverAPantallaOfertas(_ sender: Any) {
        if PagoChanged == 0 {
            if(totalAPagar == 0){
                totalAPagar = datos?.offers[indice!].items[indice!].price ?? 0
                totalpedido = 1
                print("total a pagar: \(totalAPagar)")
                print("total de pedidos: \(totalpedido)")
            }else{
                totalAPagar = totalAPagar + (datos?.offers[indice!].items[indice!].price ?? 0)
                totalpedido += 1
                print("total a pagar: \(totalAPagar)")
                print("total de pedidos: \(totalpedido)")
            }
        }else{
            if(totalAPagar == 0){
                totalAPagar = datos?.offers[indice!].items[indice!].price ?? 0
                totalpedido = 1
                print("total a pagar: \(totalAPagar)")
                print("total de pedidos: \(totalpedido)")
            }else{
                totalAPagar = totalAPagar + PagoChanged
                totalpedido = totalpedido + pedidoChanged
                print("total a pagar: \(totalAPagar)")
                print("total de pedidos: \(totalpedido)")
            }
            
        }
        dismiss(animated: true, completion: nil)
        //self.performSegue(withIdentifier: "VolveraOfertas", sender: totalAPagar)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//            if segue.identifier == "VolveraOfertas" {
//                if let destino = segue.destination as? OfertasViewController {
//                    destino.total = totalAPagar
//                    destino.pedido = totalpedido
//
//                  //  print(destino.total!)
//                }
//            }
//
//
//        }
  
}
