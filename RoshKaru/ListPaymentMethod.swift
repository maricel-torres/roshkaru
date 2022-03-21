import UIKit


class ListPaymentMethod:UITableViewController{
    
    @IBOutlet weak var tipoPago: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var dateCard: UILabel!
    
    var accessToken:String? = "b15d29a2-6517-4309-b03f-d9a29c7ca5e5"
    var payMethods = [PayMethod]()
    var carKey:String?
    var totalPagar:Int?
    var keypayMethodSelected:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Metodos de Pago"
        list_payment_methods(accessToken: accessToken!)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        payMethods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pay-cell", for: indexPath) as? PayCell
        cell?.pay = payMethods[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.keypayMethodSelected = payMethods[indexPath.row].key
        self.performSegue(withIdentifier: "confirmacion", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmacion" {
            if let nextViewController = segue.destination as? ConfirmacionViewController {
                nextViewController.accessToken = self.accessToken!
                nextViewController.carKey = self.carKey
                nextViewController.metodoPagoKey = self.keypayMethodSelected
            }
        }
    }
    
    func list_payment_methods (accessToken:String) {
        let BASEURL = "https://phoebe.roshka.com/eat"
        var urlComponents = URLComponents(string: "\(BASEURL)/list_payment_methods")!
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
                    print("Hola")
                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                    self.payMethods = self.DecodeJsonPay("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("# Success")
                }
            }
        }.resume()
    }
    
    private func moreNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
    }
    
    @objc private func add(_ sender: Any?) {
        self.instanciarViewController()
    }
    
    private func instanciarViewController() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UIViewController-XCO-QN-RFv")
        let inNavigationController = true
        if inNavigationController {
            //let nav = UINavigationController(rootViewController: controller)
            if let controller = controller as? MedioPagoViewController {
                controller.accessToken = self.accessToken
            }
            //self.present(nav, animated: true, completion: nil)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    public func DecodeJsonPay(_ jsonString: String)-> [PayMethod] {
        let listaJson = try? JSONDecoder().decode([PayMethod].self, from: jsonString.data(using: .utf8)!)
        if let listaJson = listaJson{
            print(listaJson)
        }
        return listaJson!
    }

    public func DecodeJsonPayData(_ jsonString: String)-> PayMethod {
        let listaJson = try? JSONDecoder().decode(PayMethod.self, from: jsonString.data(using: .utf8)!)

       return listaJson!
    }
    
}


struct PayMethod : Codable{
    var key: String
    var data: DataMethod
}

struct DataMethod : Codable{
    
    var cardExpirationMonth : Int?
    var cardNumbers : String?
    var replace : Bool
    var cardSecurityCode : String?
    var cardExpirationYear : Int?
    var creditCard : Bool
    var accessToken : String
    var type : String
    var cardHolderName : String?
    
}

class PayCell:UITableViewCell {
    
    @IBOutlet weak var tipoPago: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var dateCard: UILabel!
    @IBOutlet weak var imgenPay: UIImageView!
    
    var pay : PayMethod? {
        didSet {
            if let credit = pay?.data.cardNumbers {
                tipoPago.text = "Tarjeta de Crédito"
                cardNumber.text = credit
                if let cardExpirationMonth = pay?.data.cardExpirationMonth,
                   let cardExpirationYear = pay?.data.cardExpirationYear {
                    dateCard.text = "\(String(cardExpirationMonth))/\(String(cardExpirationYear))"
                }
                imgenPay.image = UIImage(named: "card")
                cardNumber.translatesAutoresizingMaskIntoConstraints = false
                cardNumber.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
                
            }else{
                tipoPago.text = "Pago en Efectivo"
                cardNumber.isHidden = true
                dateCard.isHidden = true
                dateCard.isHidden = true
                imgenPay.image = UIImage(named: "cash")
                tipoPago.translatesAutoresizingMaskIntoConstraints = false
                tipoPago.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
            }
            
        }
    }
    
}
