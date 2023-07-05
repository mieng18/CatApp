//
//  APIService.swift
//  CatApp
//
//  Created by mai nguyen on 6/22/23.
//

import Foundation
import UIKit

typealias NetworkCompletion  = (_ data: Data?, _ errorMessage: String?) -> Void

enum Result {
    case success
    case failure(message: String)
}

enum NetworkError {
    case jsonError
    case authError
    case unknown
}


class APIService {
    var task: URLSessionDataTask?
    
    func createRequest(client: EndpointProtocol, completion: @escaping NetworkCompletion) {
        
        guard let request = client.request else {return}
        
        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration)
        
        
        task = urlSession.dataTask(with: request) {(data, response,error) in
            if error != nil {return }
            
            guard let response = response as? HTTPURLResponse   else {return}
            let result = self.checkResponse(httpUrlResponse: response)
            switch result {
                case .success:if data != nil {
                    completion(data, nil)
                }
                case .failure(let message):
                    completion(nil, message)
                }
                
            
            
        }
        task?.resume()
    }
    
    
    func checkResponse(httpUrlResponse: HTTPURLResponse) -> Result {
        switch httpUrlResponse.statusCode {
        case 200...299: return .success
        default: return .failure(message: "Ooop! something went wrong")
        }
    }
    
    
    func fetchData<T: Decodable>(client: EndpointProtocol, completion: @escaping (T?) -> Void) {
        self.createRequest(client: client) { data, errorMessage in
            
            
            if data != nil, errorMessage == nil {
                let jsonDecoder = JSONDecoder()
                do {
                    let objects = try jsonDecoder.decode(T?.self, from: data!)
                    completion(objects)
                    
                } catch {
                    completion(nil)
                }
                
            }
        }
    }
}


extension UIImageView {
    func downloadImage(urlString: String){
        guard let imageURL = URL(string: urlString) else {return}
        
        
        var task = URLSession.shared.dataTask(with: imageURL) {(data, response, error) in
            
            if data != nil, error == nil{
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
            .resume()
    }
}
