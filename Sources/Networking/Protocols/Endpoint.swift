//
//  Endpoint.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 20/10/2022.
//

import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: RequestType { get }
    var headers: [String: String] { get }
    var body: [String: String] { get }
    
    func generateRequestURL() throws -> URLRequest
}

public extension Endpoint {
    var scheme: String {
        return APIConstants.scheme
    }
    
    var host: String {
        return APIConstants.host
    }
    
    func generateRequestURL() throws -> URLRequest {

        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path

        guard let url = urlComponents.url else { throw RequestErrorType.invalideURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        if !body.isEmpty {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        return urlRequest
    }
}

