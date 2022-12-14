//
//  ImageService.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 2/11/2022.
//

import Foundation
import UIKit

@available(iOS 15.0.0, *)
public struct ImageService {
    
    private let api: API
    
    init(_ api: API = API()) {
        self.api = api
    }
    
    public func perform(from url: URL) async throws -> UIImage {
        let data = try await api.makeRequest(from: url)
        guard let image = UIImage(data: data) else { throw RequestErrorType.DecodingError }
        return image
    }
}
