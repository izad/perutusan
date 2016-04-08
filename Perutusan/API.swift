//
//  API.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/8/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireJsonToObjects
import EVReflection

class API {
    
    var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func request<T: EVObject>(module: String, method: Alamofire.Method, parameters: [String: AnyObject]?, completion: (T) -> ()) {
        let request = Alamofire.request(method, "\(kBaseAPIURL)/\(module)",
            parameters: parameters
        )
        
        request.responseJSON { (response) in
            self.handleResponseJSON(request: request, response: response, success: {
                request.responseObject { (result: Result<T, NSError>) in
                    self.handleResponseObject(result, completion: completion)
                }
            })
        }
    }
    
    func handleResponseJSON(request request: Request, response: Response<AnyObject, NSError>, success: ()->()) {
        if response.result.error != nil {
            print(response.response!.statusCode)
            
            if let viewController = self.viewController {
                UIAlertController.showAlertWithTitle("Error", message: "Failed to fetch data from API (\(response.response!.statusCode))", inViewController: viewController)
            }
        }
        else {
            switch response.response!.statusCode {
                case 200:
                    success()
                    
                default:
                    print(response.response!.statusCode)
            }
        }
    }
    
    func handleResponseObject<T: EVObject>(result: (Result<T, NSError>), completion: (T) -> ()) {
        if let object = result.value {
            completion(object)
        }
    }
        
}


