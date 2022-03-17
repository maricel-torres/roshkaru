//
//  PrincipalTableViewController.swift
//  RoshKaru
//
//  Created by Bootcamp on 3/11/22.
//  Copyright © 2022 Bootcamp. All rights reserved.
//

import UIKit

class PrincipalTableViewController: UITableViewController {
    
    var accessToken:String?
    var cooks:[Cook]?
    override func viewDidLoad() {
        self.accessToken = "3463746f-9d6a-4926-a7fc-a081fd97e09a"
        weekly_plans_cooks(accessToken: self.accessToken!)
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cooks?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "principal-cell", for: indexPath) as? CookCell
        cell?.cook = cooks?[indexPath.row]
        
        return cell!
    }


    func weekly_plans_cooks (accessToken:String) {
        let BASEURL = "https://phoebe.roshka.com/eat"
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
                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                    self.cooks = self.DecodeJson("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("# Success")
                }
            }
        }.resume()
    }
    
    func DecodeJson(_ jsonString: String)-> [Cook] {
        let listaJson = try? JSONDecoder().decode([Cook].self, from: jsonString.data(using: .utf8)!)
        if let listaJson = listaJson {
            print(listaJson)
        }
        return listaJson!
    }



    /*
    // MARK: - Navigation
    */
}

class CookCell: UITableViewCell {
    
    @IBOutlet weak var nameCook: UILabel!
    @IBOutlet weak var avatarCook: UIImageView!
    var cook : Cook? {
        didSet {
            nameCook.text = cook?.name
            let urlString = cook?.photoUrl ?? "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png"
            let url = URL(string: urlString)!
            
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        //self.avatarCook.contentMode = .scaleToFill
                        self.avatarCook.image = image.cropsToSquare()
                        self.nameCook.text = self.cook?.name
                        //self.avatarCook.setRounded()
                        //self.avatarCook.image = image
                    }
                }
            }
            
//            avatarCook.translatesAutoresizingMaskIntoConstraints = false
//            avatarCook.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//            avatarCook.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            
            
        }
    }
}

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2.0) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}

extension UIImage {
    func cropsToSquare() -> UIImage {
        let refWidth = CGFloat((self.cgImage!.width))
        let refHeight = CGFloat((self.cgImage!.height))
        let cropSize = refWidth > refHeight ? refHeight : refWidth
        
        let x = (refWidth - cropSize) / 2.0
        let y = (refHeight - cropSize) / 2.0
        
        let cropRect = CGRect(x: x, y: y, width: cropSize, height: cropSize)
        let imageRef = self.cgImage?.cropping(to: cropRect)
        let cropped = UIImage(cgImage: imageRef!, scale: 0.0, orientation: self.imageOrientation)
        
        return cropped
    }
}

