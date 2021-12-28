//



import UIKit
import Alamofire
import SwiftyJSON

class Net {
    class func req(urlAPI: String, method: HTTPMethod, params: [String : Any]?, complition: @escaping (_ data: JSON?) -> () ) {
        if Reachability.isConnectedToNetwork() {
//            Loader.start()
            AF.request(urlAPI, method: method, parameters: params).responseJSON { (response) in
                if let data = response.data {
                    complition(JSON(data))
                } else {
                    complition(nil)
                    Alert.showAlert(forState: .error, message: "Error server")
                }
               // Loader.stop()
            }
        } else {
            Alert.showAlert(forState: .error, message: "Your device is not connected to the Internet")
        }
    }
}
