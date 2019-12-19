
//
//  WebSerive.swift
//  Good News
//
//  Created by PRIYANS on 18/12/19.
//  Copyright © 2019 PRIYANS. All rights reserved.
//

import Foundation



enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}


struct Resource<T: Codable> {
    var url: URL?
  
    mutating func createURL()-> URL? {
        var components = URLComponents()
        var currentDate = Date()
           components.host = "newsapi.org"
           components.path = "/v2/everything"
           components.scheme = "https"
           let queryItem = [
               URLQueryItem(name: "q", value: "apple"),
               URLQueryItem(name: "from", value: currentDate.getFromDateAsString()),
               URLQueryItem(name: "to", value: currentDate.getToDateAsString()),
               URLQueryItem(name: "sortBy", value: "popularity"),
               URLQueryItem(name: "apiKey", value: "b3830635c2944797b33ed498b17f3f19"),
           ]

           components.queryItems = queryItem

        if let url = components.url {
            return url
        } else {
            return nil
        }
           
    }
    
    init() {
        self.url = createURL()
    }
    
}



class WebServices {
    
    func loadArticles<T>(resourse: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = resourse.url else { completion(.failure(NetworkError.urlError)); return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }

}
