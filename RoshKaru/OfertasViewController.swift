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

class OfertasViewController: UITableViewController {
    var BASEURL = "https://texo.thebirdmaker.com/eat"
    var weklyPlans : [Cook]?
    var at = "ca6dfba0-8f01-401e-bc0c-c04607a3ee0b"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        weekly_plans_cooks(accessToken: at)
        
        
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
        if let listaJson = listaJson {
            print(listaJson)
        }
        return listaJson!
    }
    
    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
//        celda?.diaHora.text = weklyPlans?[0].offers[indexPath.section].items[indexPath.row].day
//        celda?.titulo.text = weklyPlans?[0].offers[indexPath.section].items[indexPath.row].title
//        celda?.precio.text = String(weklyPlans?[0].offers[indexPath.section].items[indexPath.row].price ?? 0)
//        celda?.descripcion.text = weklyPlans?[0].offers[indexPath.section].items[indexPath.row].description
        
       // let label = celda.viewWithTag(1) as? UILabel
       // label?.text = weklyPlans?[0].offers[indexPath.section].items[indexPath.row].day
        
         return celda!
    }
}

class OfertaCell: UITableViewCell {
    
    var item : Item? {
        didSet {
            
            diaHora.text = (item?.day ?? "") + "-" + (item?.dayPart ?? "")
            titulo.text = item?.title
            precio.text = "Gs." + String(item?.price ?? 0)
            descripcion.text = "Reseña: " + (item?.description ?? "")
//            print(diaHora!)
//            print(titulo!)
//            print(precio!, descripcion!)
            
        }
    }
    
    @IBOutlet weak var diaHora: UILabel!
 
    
    @IBOutlet weak var precio: UILabel!
    
    
    @IBOutlet weak var titulo: UILabel!


    @IBOutlet weak var descripcion: UILabel!
    
    override func awakeFromNib() {
        
        
    }
    
}
