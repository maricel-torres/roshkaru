//
//  eat_calls.swift
//  testing
//
//  Created by fran on 2022-03-11.
//
import UIKit

class EatCalls{
//
//    private static var BASEURL = "https://phoebe.roshka.com/eat"
////    private static var BASEURL = "http://localhost:8080/eat"
//    static func all_calls_example() {
//
//
//        var at: String = "b15d29a2-6517-4309-b03f-d9a29c7ca5e5"
////      let at = "1442c366-a673-4b81-adbe-b022a4a1e93a"
//        //let at = "73f6ccb8-a4f0-4e71-86fc-9473df433280" // local
//
////      start_login(phoneNumber: "0971305003", accessToken: nil)
////      input_sms(accessToken: at, input: "011c945f30ce2cbafc452f39840f025693339c42")
////      input_name(accessToken: at, name: "Yesss")
////      toggle_traits(accessToken: at, trait: .eater)
////      set_location(accessToken: at, addressType: .delivery, latitude: 45.5555, longitude: 24.22222)
////        set_address(accessToken: at, addressType: .delivery, streetName: "Tte. Cusmanish", number: "833", neighborhood: "Las Mercedes", reference: "barrio cerrado de roshka")
////      weekly_plans_cooks(accessToken: at)
////      /// TODO: add parameters
////      var cartKey: String? = "7a625cfe-dbb3-4bf5-b8e3-4b384ba9658b"
//
//        var cartKey: String? = "55ecabfb-de70-492e-8c31-104775a86037"
////      add_item_to_cart(accessToken: at, cartKey: cartKey, cookKey: "48468369-1668-486f-b209-092af2ea283c", offerKey: "709d6809-459c-4c08-a754-0a8442fcbca1", itemKey: "1bcea31c-7225-461e-913f-1978ae560c3f", quantity: 1)
//
////        add_payment_method(accessToken: at, type: .cash, cardHolderName: nil, cardNumbers: nil, cardExpirationMonth: nil, cardExpirationYear: nil, cardSecurityCode: nil)
////        add_payment_method(accessToken: at, type: .credit_card, cardHolderName: "OK PUPX", cardNumbers: "1234-1234-5678-8765", cardExpirationMonth: 12, cardExpirationYear: 2024, cardSecurityCode: "123")
//
////        list_payment_methods(accessToken: at)
//
//
////        close_cart(accessToken: at, cartKey: cartKey, confirm: false)
////        close_cart(accessToken: at, cartKey: cartKey, confirm: true)
//
//        let paymentMethodKey = "70e78dc3-4a64-4007-9123-7e898f817b46"
//        pay_cart(accessToken: at, cartKey: cartKey, paymentMethodKey: paymentMethodKey, total: 100000)
//
//
//    }
//
////        start_login
////        ===========
////          Http Method: GET
////
////          Inicia el login. El inicio se hace enviando un número de teléfono (phoneNumber)
////
////        Parametros:
////
////        @NotBlank String phoneNumber
////            [Es el número te teléfono que hay que enviar]
////        private String accessToken;
////
////        ** Cuando un parámetro tiene adelante @NotBlank significa que no es opcional)!
////
//
//    static func test_start_login() {
//        start_login(phoneNumber: "0971305003", accessToken: nil)
//    }
//
//    static func start_login(phoneNumber: String, accessToken:String? ) {
//
//        var urlComponents = URLComponents(string: "\(BASEURL)/start_login")!
//        var queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "phoneNumber", value: phoneNumber),
//        ]
//        if accessToken != nil {
//            queryItems.append(URLQueryItem(name: "accessToken", value: accessToken!))
//        }
//        urlComponents.queryItems = queryItems
//        let url = urlComponents.url!
//        print(url.absoluteString)
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error);
//            } else if let data = data {
//
//                let json = try! JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
//
//                print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
//
//
//            }
//        }.resume()
//
//    }
//
//
////        input_sms
////        =========
////
////        @NotBlank
////        private String accessToken;
////          Esta variable es devuelta en session en la primera llamada.
////          Hay que usar como parámtro en todas las demás llamadas para identificar al usuario actual.
////        @NotBlank
////        private String input;
////          Es el SHA1 del texto que ingresa el usuario como sms que le ha llegado.
//
//    static func test_input_sms() {
//        input_sms(accessToken: "", input: "2342349238487236487sdfasdf")
//    }
//
//    static func input_sms(accessToken:String, input: String ) {
//
//        var urlComponents = URLComponents(string: "\(BASEURL)/input_sms")!
//        let queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "accessToken", value: accessToken),
//            URLQueryItem(name: "input", value: input),
//        ]
//        urlComponents.queryItems = queryItems
//        let url = urlComponents.url!
//        print(url.absoluteString)
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error);
//            } else if let data = data {
//
//                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
//                if let json = json {
//                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
//                } else {
//                    successReally(data)
//                }
//
//
//            }
//        }.resume()
//
//    }
//
////
////        input_name
////        ==========
////
////        @NotBlank
////        private String accessToken;
////
////        @NotBlank
////        private String name;
////          El nombre ingresado por el usuario
//
//    static func test_name() {
//        input_name(accessToken: "", name: "alexis")
//    }
//
//    static func input_name(accessToken:String, name: String ) {
//        var urlComponents = URLComponents(string: "\(BASEURL)/input_name")!
//        let queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "accessToken", value: accessToken),
//            URLQueryItem(name: "name", value: name),
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
//                } else {
//                    successReally(data)
//                }
//            }
//        }.resume()
//    }
//
//
////
////        toggle_traits
////        =============
////          Agrega si no tiene (o substrae si ya tenía) el Trait (cook, eater) del usuario identificado por accessToken
////
////        @NotEmpty
////        private List<Trait> traits = new ArrayList<>();
////
////        public enum Trait {
////            cook,
////            eater;
////        }
//
//    enum Trait: String {
//        case cook
//        case eater
//    }
//
//    static func toggle_traits(accessToken:String, trait: Trait) {
//
//        var urlComponents = URLComponents(string: "\(BASEURL)/toggle_traits")!
//        let queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "accessToken", value: accessToken),
//            URLQueryItem(name: "traits", value: trait.rawValue),
//        ]
//        urlComponents.queryItems = queryItems
//        let url = urlComponents.url!
//        print(url.absoluteString)
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error);
//            } else if let data = data {
//
//                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
//                if let json = json {
//                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
//                } else {
//                    successReally(data)
//                }
//
//
//            }
//        }.resume()
//
//    }
//
////
////        set_location
////        ============
////
////        Establece el location del usuario para un cierto tipo de address (addressType).
////        La llamada guarda la latitude y longitude del usuario identificado por accessToken, para la dirección de tipo AddressType
////
////        public enum AddressType {
////            delivery, cook_site
////        }
////
////        @NotNull
////        private AddressType addressType;
////        @NotNull
////        private Double latitude;
////        @NotNull
////        private Double longitude;
//
//    static func test_set_location() {
//        set_location(accessToken: "feqwfew6+f4ew56f+4", addressType: .delivery, latitude: 45.456, longitude: 45.20)
//    }
//
//    static func set_location(accessToken:String, addressType: AddressType, latitude: Double, longitude: Double ) {
//        var urlComponents = URLComponents(string: "\(BASEURL)/set_location")!
//        let queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "addressType", value: addressType.rawValue),
//            URLQueryItem(name: "latitude", value: String(latitude)),
//            URLQueryItem(name: "longitude", value: String(longitude)),
//            URLQueryItem(name: "accessToken", value: accessToken),
//        ]
//
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
//                } else {
//                    successReally(data)
//                }
//            }
//        }.resume()
//
//    }
//
////
////        set_address
////        ===========
////          Establece la dirección del usuario identificado por el parámetro accessToken (no especificado) con los parámetros mencionados más abajo. Todos los que están marcados con @NotNull o @NotBlank no son opcionales.
////
////
////        @NotNull private InputLocation.AddressType addressType;
////        @NotBlank private String streetName;
////        @NotBlank private String number;
////        @NotBlank private String neighborhood;
////        private String reference;
//
//    static func test_set_address() {
//        set_address(accessToken: "", addressType:.delivery, streetName: "Mcal Lopez", number: "984", neighborhood: "Villa Morra", reference: "Shopping")
//    }
//
//    enum AddressType: String {
//        case delivery, cook_site
//    }
//
//    private static func AccessTokenQueryItem(_ at: String ) -> URLQueryItem {
//        URLQueryItem(name: "accessToken", value: at)
//    }
//
//
//    static func set_address(accessToken: String, addressType:AddressType, streetName:String, number:String, neighborhood:String, reference:String?) {
//
//        var urlComponents = URLComponents(string: "\(BASEURL)/set_address")!
//        var queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "addressType", value: addressType.rawValue),
//            URLQueryItem(name: "streetName", value: streetName),
//            URLQueryItem(name: "number", value: number),
//            URLQueryItem(name: "neighborhood", value: neighborhood),
//            AccessTokenQueryItem(accessToken),
//        ]
//        if let reference = reference {
//            queryItems.append(URLQueryItem(name: "reference", value: reference))
//        }
//        urlComponents.queryItems = queryItems
//        let url = urlComponents.url!
//        print(url.absoluteString)
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error);
//            } else if let data = data {
//
//                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
//                if let json = json {
//                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
//                } else {
//                    successReally(data)
//                }
//
//
//            }
//        }.resume()
//
//    }
//
////        weekly_plans/cooks
////        ==================
////          Lista los cocineros y sus ofertas. accessToken identifica al usuario que está pidiendo la lista.
////
////        @RequestParam String accessToken
////
//
////    static func test_weekly_plans () {
////        weekly_plans_cooks(accessToken: "")
////      }
////
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
////                    DecodeJson("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
//                } else {
//                    successReally(data)
//                }
//            }
//        }.resume()
//    }
//
////        add_payment_method
////        ==================
////          Agregar método de pago. type es no opcional e identifica el tipo de medio de pago.
////          Si el pago es tarjeta, los demás campos deben ser llenados.
////          cardHolderName: Nombre en la tarjeta
////          cardNumbers: número de la tarjeta
////          cardExpirationMonth y cardExpirationYear: expresan la fecha de vencimiento de la tarjeta.
////          cardSecurityCode: el código de seguridad de la tarjeta.
////
////        public enum Type {
////            credit_card,
////            cash,
////        }
////        @NotBlank
////        private Type type;
////
////        private cardHolderName: String?,
////        private cardNumbers: String?,
////        private cardExpirationMonth: Int?,
////        private cardExpirationYear: Int?,
////        private cardSecurityCode: String?,
//
//    static func test_add_payment_method() {
//        add_payment_method(accessToken: "", type: .credit_card, cardHolderName: "Nicolas Cage", cardNumbers: "1233-1231-1243-4343", cardExpirationMonth: 12, cardExpirationYear: 2024, cardSecurityCode: "348")
//    }
//
//    enum PaymentType: String {
//        case credit_card
//        case cash
//    }
//
//    static func add_payment_method(accessToken: String,
//                                   type:PaymentType,
//                                   cardHolderName: String?,
//                                   cardNumbers: String?,
//                                   cardExpirationMonth: Int?,
//                                   cardExpirationYear: Int?,
//                                   cardSecurityCode: String?
//    ) {
//
//        var urlComponents = URLComponents(string: "\(BASEURL)/add_payment_method")!
//        var queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "type", value: type.rawValue),
//            AccessTokenQueryItem(accessToken)
//        ]
//        if let cardHolderName = cardHolderName {
//            queryItems.append(URLQueryItem(name: "cardHolderName", value: cardHolderName))
//        }
//        if let cardNumbers = cardNumbers {
//            queryItems.append(URLQueryItem(name: "cardNumbers", value: cardNumbers))
//        }
//        if let cardExpirationMonth = cardExpirationMonth {
//            queryItems.append(URLQueryItem(name: "cardExpirationMonth", value: String(cardExpirationMonth)))
//        }
//        if let cardExpirationYear = cardExpirationYear {
//            queryItems.append(URLQueryItem(name: "cardExpirationYear", value: String(cardExpirationYear)))
//        }
//        if let cardSecurityCode = cardSecurityCode {
//            queryItems.append(URLQueryItem(name: "cardSecurityCode", value: cardSecurityCode))
//        }
//
//
//        urlComponents.queryItems = queryItems
//        let url = urlComponents.url!
//        print(url.absoluteString)
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error);
//            } else if let data = data {
//
//                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
//                if let json = json {
//                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
//                } else {
//                    successReally(data)
//                }
//
//            }
//        }.resume()
//
//    }
//
////
////        list_payment_methods
////        ====================
////          Lista los métodos de pago ya disponibles por el usuario.
////
////        @RequestParam String accessToken
//
//    static func test_list_payment_methods() {
//        list_payment_methods(accessToken: "")
//    }
//
//    static func list_payment_methods (accessToken:String) {
//        var urlComponents = URLComponents(string: "\(BASEURL)/list_payment_methods")!
//        let queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "accessToken", value: accessToken)
//        ]
//        let debug = true
//        urlComponents.queryItems = queryItems
//        let url = urlComponents.url!
//        print(url.absoluteString)
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//              print(error);
//            } else if let data = data {
//
//                let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
//                if let json = json {
//                    print("\(String(data: try! JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]), encoding: .utf8)!)")
//                } else {
//                    successReally(data)
//                }
//            }
//        }.resume()
//    }
//
//
////
////        add_item_to_cart
////        ================
////          Agrega un item a un Carro de compras. Si el parámetro `cartKey` está vacío, se creará primero un nuevo carro ante de agregar el item. Se retorna el Carro con sus items.
////          cookKey + offerKey + itemKey: identifica el ítem que se está agregando.
////          quantity: la cantidad de objetos de este tipo que se están agregando. Puede ser negativo, para restar items. Puede ser cero.
////
////        private String cartKey;
////        @NotBlank
////        private String cookKey;
////        @NotBlank
////        private String offerKey;
////        @NotBlank
////        private String itemKey;
////        @NotBlank
////        private int quantity;
//
//    static func test_add_item_to_cart() {
//        add_item_to_cart(accessToken: "", cartKey: "7890adaewe", cookKey: "7893kaiekc", offerKey: "2355addsha", itemKey: "ahajd8739ashfe", quantity: 1)
//    }
//
//    static func add_item_to_cart(accessToken:String, cartKey: String?, cookKey:String, offerKey: String, itemKey: String, quantity: Int ) {
//        var urlComponents = URLComponents(string: "\(BASEURL)/add_item_to_cart")!
//        var queryItems: [URLQueryItem] = [
//            URLQueryItem(name: "cookKey", value: cookKey),
//            URLQueryItem(name: "offerKey", value: offerKey),
//            URLQueryItem(name: "itemKey", value: itemKey),
//            URLQueryItem(name: "quantity", value: String(quantity)),
//            URLQueryItem(name: "accessToken", value: accessToken)
//        ]
//        if let cartKey = cartKey {
//            queryItems.append(URLQueryItem(name: "cartKey", value: cartKey))
//        }
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
//
//                } else {
//                    successReally(data)
//                }
//            }
//        }.resume()
//    }
//
//
//    //close_cart
//    //==========
//    //var accessToken: String
//    //var cartKey: String
//    //var confirm: Bool = false; // tiene valor por defecto, si no se envia nada, es false
//
//    static func test_close_cart() {
//        close_cart(accessToken: "be73b556-4de1-402b-84b9-0f0a0977b5fb", cartKey: "7890adaewe", confirm: false)
//    }
//
//    static func close_cart(accessToken:String, cartKey: String?, confirm: Bool) {
//
//        var urlComponents = URLComponents(string: "\(BASEURL)/close_cart")!
//
//        var queryItems: [URLQueryItem] = [
//            AccessTokenQueryItem(accessToken),
//            URLQueryItem(name: "cartKey", value: cartKey),
//            URLQueryItem(name: "confirm", value: String(confirm))
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
//
//                } else {
//                    successReally(data)
//                }
//            }
//        }.resume()
//    }
//
//    private static func successReally(_ data: Data) {
//        if let str = String(data: data, encoding: .utf8), str.count > 0  {
//            print("_WOOOPS_______________________________________________\n\(str)")
//        } else {
//            print("# Success")
//        }
//    }
//
//
//    //pay_cart
//    //========
//    //var accessToken: String
//    //var cartKey: String
//    //var paymentMethodKey: String
//    //var total: Int
//
//    static func test_pay_cart() {
//        pay_cart(accessToken: "be73b556-4de1-402b-84b9-0f0a0977b5fb", cartKey: "7890adaewe", paymentMethodKey: "Efectivo", total: 100000)
//    }
//
//    static func pay_cart(accessToken:String, cartKey: String?, paymentMethodKey: String?, total: Int?) {
//        var urlComponents = URLComponents(string: "\(BASEURL)/pay_cart")!
//
//        var queryItems: [URLQueryItem] = [
//            AccessTokenQueryItem(accessToken),
//            URLQueryItem(name: "cartKey", value: cartKey),
//            URLQueryItem(name: "paymentMethodKey", value: paymentMethodKey),
//            URLQueryItem(name: "total", value: String(total!))
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
//
//                } else {
//                    successReally(data)
//                }
//            }
//        }.resume()
//    }
//    //orders
//    //======
//    //var accessToken: String
//
//    static func test_orders() {
//        orders(accessToken: "be73b556-4de1-402b-84b9-0f0a0977b5fb")
//    }
//
//    static func orders(accessToken:String) {
//
//        var urlComponents = URLComponents(string: "\(BASEURL)/orders")!
//        var queryItems: [URLQueryItem] = [
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
//
//                } else {
//                    successReally(data)
//                }
//            }
//        }.resume()
//    }
//
//
////    close_cart
////    ==========
////    var accessToken: String
////    var cartKey: String
////    var confirm: Bool = false; // tiene valor por defecto, si no se envia nada, es false
//
//    static func close_cart(accessToken: String, cartKey: String, confirm: Bool) {
//
//        var urlComponents = URLComponents(string: "\(BASEURL)/close_cart")!
//        let queryItems: [URLQueryItem] = [
//            AccessTokenQueryItem(accessToken),
//            URLQueryItem(name: "cartKey", value: cartKey),
//            URLQueryItem(name: "confirm", value: String(cartKey)),
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
//
//                } else {
//                    successReally(data)
//                }
//            }
//        }.resume()
//    }
//
////    pay_cart
////    ========
////    var accessToken: String
////    var cartKey: String
////    var paymentMethodKey: String
////    var total: Int
//
//    static func pay_cart(accessToken: String, cartKey: String, paymentMethodKey: String, total: Int) {
//
//        var urlComponents = URLComponents(string: "\(BASEURL)/pay_cart")!
//        let queryItems: [URLQueryItem] = [
//            AccessTokenQueryItem(accessToken),
//            URLQueryItem(name: "cartKey", value: cartKey),
//            URLQueryItem(name: "paymentMethodKey", value: paymentMethodKey),
//            URLQueryItem(name: "total", value: String(total)),
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
//
//                } else {
//                    successReally(data)
//                }
//            }
//        }.resume()
//    }
//
//}

// conversion a SHA1
//import CommonCrypto
//import CryptoKit
//import Foundation
//
//private func hexString(_ iterator: Array<UInt8>.Iterator) -> String {
//    return iterator.map { String(format: "%02x", $0) }.joined()
//}
//
//extension Data {
//
//    public var sha1: String {
//        if #available(iOS 13.0, *) {
//            return hexString(Insecure.SHA1.hash(data: self).makeIterator())
//        } else {
//            var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
//            self.withUnsafeBytes { bytes in
//                _ = CC_SHA1(bytes.baseAddress, CC_LONG(self.count), &digest)
//            }
//            return hexString(digest.makeIterator())
//        }
//    }
//
}



