//
//  OfertasViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
import GMStepper

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
//estructura de weeklyplans
struct Cook : Codable{
    var offers: [Offer]
    var kitchenPhotoUrl: String?
    var key: String
    var description: String
    var photoUrl: String
    var name: String
    var kitchen: String
}
struct ItemsCart: Codable {
    var cartKey : String?
    var quantity: Int
    var offerKey: String
    var itemKey: String
    var replace: Bool
    var accessToken: String
    var cookKey: String
}
// estructura del carrito
struct Cart : Codable {
    var items: [ItemsCart]
    var cartKey: String
    var total: Double
}
class OfertasViewController: UITableViewController {
    var indexOffers:Int?
    var indexItems : Int?
    var totalAPagar: Int = 0
    var totalpedido: Int = 0
    var BASEURL = "https://phoebe.roshka.com/eat"
    var weklyPlans : [Cook]?
    var accessToken: String? = "b15d29a2-6517-4309-b03f-d9a29c7ca5e5"
    var indexCook: Int?
    var cart: Cart?
    var total : Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        weekly_plans_cooks(accessToken: accessToken!)
        
    }
    // Accion del boton cuando se aprienta
    @objc func IrAMedioPago(_ sender: UIButton){
            self.performSegue(withIdentifier: "MedioPago", sender: self.accessToken!)
        }
  
// Agrega items al carrito
     func add_item_to_cart(accessToken:String, cartKey: String?, cookKey:String, offerKey: String, itemKey: String, quantity: Int ) {
        var urlComponents = URLComponents(string: "\(BASEURL)/add_item_to_cart")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "cookKey", value: cookKey),
            URLQueryItem(name: "offerKey", value: offerKey),
            URLQueryItem(name: "itemKey", value: itemKey),
            URLQueryItem(name: "quantity", value: String(quantity)),
            URLQueryItem(name: "accessToken", value: accessToken)
        ]
        if let cartKey = cartKey {
            queryItems.append(URLQueryItem(name: "cartKey", value: cartKey))
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
                    self.cart = self.DecodeJsonCart("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                    DispatchQueue.main.async {
                        self.cartKey = self.cart?.cartKey
                        self.total = self.cart?.total
                        self.botonMagico()
                        self.bonBoton!.addTarget(self, action: #selector(self.IrAMedioPago(_:)), for: .touchUpInside)
                    }
                    
                } else {
                    print("# Success")
                }
            }
        }.resume()
    }
    private var cartKey: String?
// llama a la funcion agregar carrito  y muestra el boton de pedido y total a pagar
    func itemAgregado(_ cook: Cook, _ offer: Offer, _ item: Item, _ cantidad: Int){
        if(cartKey == nil){
            add_item_to_cart(accessToken: accessToken!, cartKey: cartKey, cookKey: cook.key, offerKey: offer.key, itemKey: item.key, quantity: cantidad)
        }else{
            add_item_to_cart(accessToken: accessToken!, cartKey: cartKey, cookKey: cook.key, offerKey: offer.key, itemKey: item.key, quantity: cantidad)
        }
        
  }
    //Boton que muestra el total a pagar y para confirmar el pedido
    private func setButtonTitle() {
        bonBoton?.setTitle("Ver mi pedido \(Int(total!))", for: .normal)
    }
    weak var bonBoton: UIButton?
    public func botonMagico () {
        let bonBoton = UIButton()
        self.bonBoton = bonBoton
        bonBoton.backgroundColor = .red
        bonBoton.tintColor = .white
        setButtonTitle()
        tableView.addSubview(bonBoton)
        bonBoton.translatesAutoresizingMaskIntoConstraints = false
        bonBoton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        bonBoton.leadingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        bonBoton.trailingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        bonBoton.layer.cornerRadius = 15
      }

// funcion que trae las ofertas del cocinero
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

//                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
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
    //funcion que decodifica las ofertas
    public func DecodeJson(_ jsonString: String)-> [Cook] {
        let listaJson = try? JSONDecoder().decode([Cook].self, from: jsonString.data(using: .utf8)!)
//        if let listaJson = listaJson {
//            print(listaJson)
//        }
        return listaJson!
    }
   // funcion que decodifica el carrito
    public func DecodeJsonCart(_ jsonString: String)-> Cart {
        let listaJson = try? JSONDecoder().decode(Cart.self, from: jsonString.data(using: .utf8)!)
//        if let listaJson = listaJson {
//            print(listaJson)
//        }
       return listaJson!
    }
    //Carga de la tabla para ver las ofertas
    override func numberOfSections(in tableView: UITableView) -> Int {
        weklyPlans?[indexCook!].offers.count ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weklyPlans?[indexCook!].offers[section].items.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "items", for: indexPath) as? OfertaCell
        celda?.item = weklyPlans?[indexCook!].offers[indexPath.section].items[indexPath.row]
         return celda!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexItems = indexPath.row
        indexOffers = indexPath.section
        self.performSegue(withIdentifier: "oferta", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "oferta" {
                if let nextViewController = segue.destination as? Quantity {
                    nextViewController.cook = weklyPlans![indexCook!]
                    nextViewController.offer = weklyPlans![indexCook!].offers[indexOffers!]
                    nextViewController.item = weklyPlans![indexCook!].offers[indexOffers!].items[indexItems!]
                    nextViewController.oferta = self
                }
            }
        if segue.identifier ==  "MedioPago"{
            if let nextviewcontroller  = segue.destination as?  ListPaymentMethod{
                nextviewcontroller.accessToken = self.accessToken
                nextviewcontroller.carKey = cartKey
                nextviewcontroller.totalPagar = Int(total!)
            }
        }
    }
}
//clase para cargar los datos a las celdas de la tabla ofertas
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
//clase para la pantalla donde se carga la cantidad y se agrega al pedido o carrito
class Quantity: UIViewController{

    var cook : Cook!
    var offer : Offer!
    var item : Item!
    var cantidad = 0
    var total = 0
    var pedidoChanged : Int = 0
    var PagoChanged: Int = 0
    @IBOutlet weak var StackView1: UIStackView!
    
    @IBOutlet weak var StackView2: UIStackView!
    
    @IBOutlet weak var StackView3: UIStackView!
    
    @IBOutlet weak var Titulo: UILabel!
    
    @IBOutlet weak var Precio: UILabel!
    
    @IBOutlet weak var AddButton: UIButton!
    
    weak var oferta: OfertasViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        StackView1.spacing = 30
        StackView2.spacing = 120
        Titulo.text = self.item.title
        Precio.text = "\(self.item.currencyCode) \(self.item.price)"
        AddButton.setTitle("Agregar a mi pedido Gs. \(String(self.item.price))", for: .normal)
        AddButton.translatesAutoresizingMaskIntoConstraints = false
        AddButton.layer.cornerRadius = 15
    }
    
    @IBOutlet weak var stepper: GMStepper!// variable del boton tipo stepper
    //Accion del boton stepper cuando cambia el valor
    @IBAction func StepperValueChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        PagoChanged = value * self.item.price
        self.AddButton.setTitle("Agregar a mi pedido Gs. \(String(PagoChanged))", for: .normal)
        pedidoChanged = Int(sender.value)
    }
    //vuelve a la pantalla ofertas para seguir haciendo pedidos o ir a confirmacion de pedidos
    @IBAction func volverAPantallaOfertas(_ sender: Any) {
        self.cantidad = Int(stepper.value)
        self.oferta?.itemAgregado(self.cook, self.offer, self.item, cantidad)
        self.total = total + self.cantidad * self.item.price
        //print(cantidad)
       // print(total)
        
        //dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}


