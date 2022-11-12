//
//  ProductService.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 20/10/2022.
//

import Foundation


@available(iOS 13.0.0, *)
protocol APIService {
    func perform<T:Decodable>(_ endpoint: Endpoint) async throws -> T
}
