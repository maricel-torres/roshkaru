import UIKit
    
class IncialViewController:UIViewController {
    private var hud: MBProgressHUD?
    var accessToken = ""
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        if let accessTokenData = userDefaults.object(forKey: "accessToken") {
            self.accessToken = String(describing: accessTokenData)
            print(self.accessToken)
            print("Principal")
            performSegue(withIdentifier: "principal", sender: nil)
        }else{
            print("Login")
            performSegue(withIdentifier: "login", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "principal" {
            if let nextViewController = segue.destination as? PrincipalTableViewController {
                nextViewController.accessToken = self.accessToken
            }
        }
    }
}
