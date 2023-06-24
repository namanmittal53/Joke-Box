//
//  WebServices.swift
//  JokeBox
//
//  Created by Naman on 24/06/23.
//

import Foundation

class WebServices {
    
    // Fetch the DATA from the API
    func fetchData(urlString: String, completion: @escaping ((String) -> ()), failure: @escaping ((Error) -> ())) {
        guard let url = URL(string: urlString) else {
            print("Not a valid URL")
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error)  in
            
            // Check the errors
            if let error = error {
                print("Error: \(error)")
                failure(error)
            }
            
            // Check if data is available
            guard let data = data else {
                print("No data received")
                return
            }
            if let dataStr = String(data: data, encoding: .utf8) {
                completion(dataStr)
            }
        }.resume()
        
    }

}
