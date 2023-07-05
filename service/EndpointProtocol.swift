//
//  EndpointProtocol.swift
//  CatApp
//
//  Created by mai nguyen on 6/22/23.
//

import Foundation


//https://api.thecatapi.com/v1/images/search?limit=20

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol EndpointProtocol {
    var baseURL: String {get}
    var path: String {get}
    var parameters: [URLQueryItem]{ get}
    var request: URLRequest? {get}
    var httpMehthod: HTTPMethod {get}
    var httpHeader: [String : String] {get}
}

enum CatEndpoint {
    case search
}

extension CatEndpoint: EndpointProtocol {
    var baseURL: String {
        return "https://api.thecatapi.com"
    }
    
    var path: String {
        return "/v1/images/search"
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case  .search: return [URLQueryItem(name: "limit", value: "20")]
        }
    }
    
    var request: URLRequest? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = parameters
        
        if let urlString = urlComponents?.url {
            var request = URLRequest(url: urlString)
            request.httpMethod = httpMehthod.rawValue
            request.allHTTPHeaderFields = httpHeader
            request.httpBody = nil
            return request
        }
        return nil
    }
    
    var httpMehthod: HTTPMethod {
        return .get
    }
    
    var httpHeader: [String : String] {
        return ["Content-Type": "application/json",
                "x-api-key": "live_dDQF6rRB5sTI2kwxcPEiSm0uvEaspXpSwcYrOyZngeQsHZrOUNT1TrjAWJuVaCQE" ]
    }
    
    
}
