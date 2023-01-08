//
//  Requester.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 13.11.2022.
//

import Foundation
import UIKit
import Alamofire

enum NetworkResponse<T> {
    case httpSuccess(T)
    case httpFail(Error)
}

protocol ProviderProtocol {
    func request<T: Decodable>(model: T.Type,
                               parameters: [String: String],
                               completion: @escaping (NetworkResponse<T>) -> Void)
}

class Requester: ProviderProtocol {

    private lazy var baseUrl = "https://newsapi.org"
    private lazy var apiKey = "b4bf5e9ea49a49a4807f83438cd8e006"

    func request<T: Decodable>(model: T.Type,
                               parameters: [String: String] = [:],
                               completion: @escaping (NetworkResponse<T>) -> Void) {
        var queryParams = parameters
        queryParams["/v2/top-headlines?country=us&apiKey"] = apiKey
        let urlString = prepareUrl(params: queryParams)
    AF.request(urlString, method: .get).responseData { data in
            switch data.result {
            case let .success(responseData):
                do {
                    let model = try JSONDecoder().decode(T.self, from: responseData)
                    completion(.httpSuccess(model))
                } catch let error as NSError {
                    completion(.httpFail(error))
                }
            case .failure(let error):
                completion(.httpFail(error))
            }
        }
    }

    private func prepareUrl(params: [String: String]) -> String {
        var resultUrl = baseUrl
        params.forEach { resultUrl += "\($0.key)=\($0.value)&" }
        resultUrl.removeLast()
        print(resultUrl)
        return resultUrl
    }
}
