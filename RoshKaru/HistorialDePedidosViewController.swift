//
//  HistorialDePedidosViewController.swift
//  RoshKaru
//
//  Created by bootcamp on 3/21/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit
struct Items: Codable {
    var cartKey: String
    var quantity : Int
    var offerKey: String
    var itemKey: String
    var replace: Bool
    var accessToken: String
    var cookKey: String
  }
struct Carts:Codable{
  var total: Double
  var key1: String
  var items: [Items]
  var key2: String
  var table: String
  var confirmed: Bool
}
struct Dato:Codable{
  var cardExpirationMonth: Int
  var cardNumbers : String
  var replace: Bool
  var cardSecurityCode : String
  var cardExpirationYear: Int
  var creditCard: Bool
  var accessToken: String
  var type: String
  var cardHolderName: String
}
struct PaymentMethod: Codable {
  var key : String
  var data: Dato
}
struct Orders: Codable {
  var key1 : String
  var paymentMethod : PaymentMethod
  var cart : Carts
  var key2: String
  var table: String
  var date: Int
}


class HistorialDePedidosViewController: UITableViewController {
    var accessToken : String?
    var historial : [Orders]?
    var BASEURL = "https://phoebe.roshka.com/eat"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Historial de Pedidos"
       orders(accessToken: accessToken!)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historial?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "items", for: indexPath) as! historialCell
        celda.historial = historial?[indexPath.row]
        
         return celda
    }
    func orders(accessToken:String) {
        
        var urlComponents = URLComponents(string: "\(BASEURL)/orders")!
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
                        print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                        
                        self.historial = self.DecodeJson("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } else {
                        self.successReally(data)
                }
            }
        }.resume()
    }
    func successReally(_ data: Data) {
        if let str = String(data: data, encoding: .utf8), str.count > 0  {
            print("_WOOOPS_______________________________________________\n\(str)")
        } else {
            print("# Success")
        }
    }
    public func DecodeJson(_ jsonString: String)-> [Orders] {
        let listaJson = try? JSONDecoder().decode([Orders].self, from: jsonString.data(using: .utf8)!)
        if let listaJson = listaJson {
            print(listaJson)
        }
       return listaJson!
    }

}

class historialCell: UITableViewCell{
    
    var historial : Orders?{
        didSet{
            cartkey.text = historial?.cart.key2
            total.text = String(Int(historial?.cart.total ?? 0))
            let ti = TimeInterval((historial?.date ?? 0) / 1000)
            let date = Date(timeIntervalSince1970: ti)
            let components = Calendar.current.dateComponents([.month, .year, .day], from: date)
            fecha.text = "\(components.day!)/\(components.month!)/\(components.year!)"
        }
    }
    
    @IBOutlet weak var cartkey: UILabel!
    
   
    @IBOutlet weak var total: UILabel!
    
    
    @IBOutlet weak var fecha: UILabel!
    
}


