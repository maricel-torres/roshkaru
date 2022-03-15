//
//  eat_calls.swift
//  testing
//
//  Created by fran on 2022-03-11.
//

import UIKit

class EatCalls{
    
    private static var BASEURL = "https://texo.thebirdmaker.com/eat"
    
    ///
    /// Estas son todas las llamadas.
    ///
    ///
    ///
    ///
    static func all_calls_example() {
        
      // let at = "73f6ccb8-a4f0-4e71-86fc-9473df433280"
       var at = "ca6dfba0-8f01-401e-bc0c-c04607a3ee0b"
        //start_login(phoneNumber: "0981123456", accessToken: at)
 //input_sms(accessToken: at, input: "011c945f30ce2cbafc452f39840f025693339c42")
//      input_name(accessToken: at, name: "Kii Kuu")
//      toggle_traits(accessToken: at, trait: .eater)
//      set_location(accessToken: at, addressType: .delivery, latitude: 45.5555, longitude: 24.22222)
//        set_address(accessToken: at, addressType: .delivery, streetName: "Tte. Cusmanish", number: "833", neighborhood: "Las Mercedes", reference: "barrio cerrado de roshka")
//weekly_plans_cooks(accessToken: at)
//        var cartKey: String? = nil
//        let cookKey = "48468369-1668-486f-b209-092af2ea283c"
//        let offerKey = "709d6809-459c-4c08-a754-0a8442fcbca1"
//        let itemKey = "1bcea31c-7225-461e-913f-1978ae560c3f"
//
//        add_item_to_cart(accessToken: at, cartKey: cartKey, cookKey: cookKey, offerKey: offerKey, itemKey: itemKey, quantity: 1)
        
    }
        
//        start_login
//        ===========
//
//        @NotBlank
//        private String phoneNumber;
//        private String accessToken;
        
    static func test_start_login() {
        start_login(phoneNumber: "0971305003", accessToken: nil)
    }
    
    static func start_login(phoneNumber: String, accessToken:String? ) {
        
        var urlComponents = URLComponents(string: "\(BASEURL)/start_login")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "phoneNumber", value: phoneNumber),
        ]
        if accessToken != nil {
            queryItems.append(URLQueryItem(name: "accessToken", value: accessToken!))
        }
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        print(url.absoluteString)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error);
            } else if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                
                print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                
                
            }
        }.resume()
        
    }
    
        
//        input_sms
//        =========
//
//        @NotBlank
//        private String accessToken;
//        @NotBlank
//        private String input;
    
    static func test_input_sms() {
        input_sms(accessToken: "", input: "2342349238487236487sdfasdf")
    }

    static func input_sms(accessToken:String, input: String ) {
        
        var urlComponents = URLComponents(string: "\(BASEURL)/input_sms")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "accessToken", value: accessToken),
            URLQueryItem(name: "input", value: input),
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
                } else {
                    print("# Success")
                }
                
                
            }
        }.resume()
        
    }
    
//
//        input_name
//        ==========
//
//        @NotBlank
//        private String accessToken;
//
//        @NotBlank
//        private String name;
    
    static func test_name() {
        input_name(accessToken: "", name: "alexis")
    }
    
    static func input_name(accessToken:String, name: String ) {
        var urlComponents = URLComponents(string: "\(BASEURL)/input_name")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "accessToken", value: accessToken),
            URLQueryItem(name: "name", value: name),
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
                } else {
                    print("# Success")
                }
            }
        }.resume()
    }

    
//
//        toggle_traits
//        =============
//
//        @NotEmpty
//        private List<Trait> traits = new ArrayList<>();
//
//        public enum Trait {
//            cook,
//            eater;
//        }
    
    enum Trait: String {
        case cook
        case eater
    }
    
    static func toggle_traits(accessToken:String, trait: Trait) {
        
        var urlComponents = URLComponents(string: "\(BASEURL)/toggle_traits")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "accessToken", value: accessToken),
            URLQueryItem(name: "traits", value: trait.rawValue),
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
                } else {
                    print("# Success")
                }
                
                
            }
        }.resume()
        
    }
    
//
//        set_location
//        ============
//
//        public enum AddressType {
//            delivery, cook_site
//        }
//
//        @NotNull
//        private AddressType addressType;
//        @NotNull
//        private Double latitude;
//        @NotNull
//        private Double longitude;
        
    static func test_set_location() {
        set_location(accessToken: "feqwfew6+f4ew56f+4", addressType: .delivery, latitude: 45.456, longitude: 45.20)
    }

    static func set_location(accessToken:String, addressType: AddressType, latitude: Double, longitude: Double ) {
        var urlComponents = URLComponents(string: "\(BASEURL)/set_location")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "addressType", value: addressType.rawValue),
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            URLQueryItem(name: "accessToken", value: accessToken),
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
                } else {
                    print("# Success")
                }
            }
        }.resume()
        
    }
    
//
//        set_address
//        ===========
//
//        @NotNull
//        private InputLocation.AddressType addressType;
//        @NotBlank
//        private String streetName;
//        @NotBlank
//        private String number;
//        @NotBlank
//        private String neighborhood;
//        private String reference;
    
    static func test_set_address() {
        set_address(accessToken: "", addressType:.delivery, streetName: "Mcal Lopez", number: "984", neighborhood: "Villa Morra", reference: "Shopping")
    }
    
    enum AddressType: String {
        case delivery, cook_site
    }

    static func set_address(accessToken: String, addressType:AddressType, streetName:String, number:String, neighborhood:String, reference:String?) {
        
        var urlComponents = URLComponents(string: "\(BASEURL)/set_address")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "addressType", value: addressType.rawValue),
            URLQueryItem(name: "streetName", value: streetName),
            URLQueryItem(name: "number", value: number),
            URLQueryItem(name: "neighborhood", value: neighborhood),
            URLQueryItem(name: "accessToken", value: accessToken),
            URLQueryItem(name: "replace", value: String(true)),
        ]
        if let reference = reference {
            queryItems.append(URLQueryItem(name: "reference", value: reference))
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
                } else {
                    print("# Success")
                }
                
                
            }
        }.resume()
        
    }
    
//        weekly_plans/cooks
//        ==================
//
//        @RequestParam String accessToken
//
    
//    static func test_weekly_plans () {
//        weekly_plans_cooks(accessToken: "")
//      }
//
//    static func weekly_plans_cooks (accessToken:String) {
//        var urlComponents = URLComponents(string: "\(BASEURL)/weekly_plans/cooks")!
//        let queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "accessToken", value: accessToken)
//        ]
//        urlComponents.queryItems = queryItems
//        let url = urlComponents.url!
//        print(url.absoluteString)
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error);
//            } else if let data = data {
//                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
//                if let json = json {
//                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
//                    DecodeJson("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
//                } else {
//                    print("# Success")
//                }
//            }
//        }.resume()
//    }
    
//        add_payment_method
//        ==================
//
//        public enum Type {
//            credit_card,
//            cash,
//        }
//        @NotBlank
//        private Type type;
//
//        private cardHolderName: String?,
//        private cardNumbers: String?,
//        private cardExpirationMonth: Int?,
//        private cardExpirationYear: Int?,
//        private cardSecurityCode: String?,
    
    static func test_add_payment_method() {
        add_payment_method(type: .credit_card, cardHolderName: "Nicolas Cage", cardNumbers: "1233-1231-1243-4343", cardExpirationMonth: 12, cardExpirationYear: 2024, cardSecurityCode: "348")
    }
    
    enum PaymentType: String {
        case credit_card
        case cash
    }
    
    static func add_payment_method(type:PaymentType,
                                   cardHolderName: String?,
                                   cardNumbers: String?,
                                   cardExpirationMonth: Int?,
                                   cardExpirationYear: Int?,
                                   cardSecurityCode: String?
    ) {
        
        var urlComponents = URLComponents(string: "\(BASEURL)/add_payment_method")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "type", value: type.rawValue),
        ]
        if let cardHolderName = cardHolderName {
            queryItems.append(URLQueryItem(name: "cardHolderName", value: cardHolderName))
        }
        if let cardNumbers = cardNumbers {
            queryItems.append(URLQueryItem(name: "cardNumbers", value: cardNumbers))
        }
        if let cardExpirationMonth = cardExpirationMonth {
            queryItems.append(URLQueryItem(name: "cardExpirationMonth", value: String(cardExpirationMonth)))
        }
        if let cardExpirationYear = cardExpirationYear {
            queryItems.append(URLQueryItem(name: "cardExpirationYear", value: String(cardExpirationYear)))
        }
        if let cardSecurityCode = cardSecurityCode {
            queryItems.append(URLQueryItem(name: "cardSecurityCode", value: cardSecurityCode))
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
                } else {
                    print("# Success")
                }
                
            }
        }.resume()
        
    }
    
//
//        list_payment_methods
//        ====================
//
//        @RequestParam String accessToken
    
    static func list_payment_methods() {
        list_payment_methods(accessToken: "")
    }
    
    static func list_payment_methods (accessToken:String) {
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
                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
                } else {
                    print("# Success")
                }
            }
        }.resume()
    }

    
//
//        add_item_to_cart
//        ================
//
//        private String cartKey;
//        @NotBlank
//        private String cookKey;
//        @NotBlank
//        private String offerKey;
//        @NotBlank
//        private String itemKey;
//        @NotBlank
//        private int quantity;
    
    static func test_add_item_to_cart() {
        add_item_to_cart(accessToken: "", cartKey: "7890adaewe", cookKey: "7893kaiekc", offerKey: "2355addsha", itemKey: "ahajd8739ashfe", quantity: 1)
    }
    
    static func add_item_to_cart(accessToken:String, cartKey: String?, cookKey:String, offerKey: String, itemKey: String, quantity: Int ) {
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
                    
                } else {
                    print("# Success")
                }
            }
        }.resume()
    }
//    struct Item : Codable {
//        var day : String
//        var title: String
//        var price: Int
//        var currencyCode: String
//        var key: String
//        var dayPart: String
//        var description: String
//    }
//    struct Offer : Codable{
//        let key: String
//        var items: [Item]
//    }
//    struct Cook : Codable{
//        var offers: [Offer]
//        var kitchenPhotoUrl: String?
//        var key: String
//        var description: String
//        var photoUrl: String
//        var name: String
//        var kitchen: String
//    }
//    static func DecodeJson(_ jsonString: String) {
//        let listaJson = try? JSONDecoder().decode([Cook].self, from: jsonString.data(using: .utf8)!)
//        if let listaJson = listaJson {
//            print(listaJson)
//        }
//    }
//    
//}

}
