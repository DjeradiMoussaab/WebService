//
//  API.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 18/10/2022.
//

import Foundation


@available(iOS 13.0.0, *)
protocol APIProtocol {
    func makeRequest(_ requestURL: URLRequest) async throws -> Data
}
@available(iOS 15.0.0, *)

public final class API: APIProtocol {
    
    private let cachedImages = NSCache<NSString, NSData>()
    public init() {
        
    }

    public func makeRequest(_ requestURL: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: requestURL)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw RequestErrorType.invalideResponse
        }
        return data
    }
    
    public func makeRequest(from url: URL) async throws -> Data {
        if let imageData = cachedImages.object(forKey: url.absoluteString as NSString) {
            return imageData as Data
        }
        let (localUrl, _) = try await URLSession.shared.download(from: url)
        let data = try Data(contentsOf: localUrl)
        cachedImages.setObject(data as NSData, forKey: url.absoluteString as NSString)
        return data
    }

}
