//
//  GoogleBooksAPI.swift
//  BookCase
//
//  Created by Mohamed Zakaria on 5/9/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import Foundation

// Results of using Google Books API
enum SearchGoogleBooksResult {
    case success
    case nothingFound
    case failure
}

// MARK: -
class GoogleBooksAPI {
    
    // MARK: - Properties
    private var session = URLSession.shared
    
    // MARK: - Singleton
    static let shared = GoogleBooksAPI()
    private init() {}
    
    // MARK: - Network Requests
    
    // Search Google Books
    func searchGoogleBooks(_ searchTerm: String, completionHandler: @escaping (SearchGoogleBooksResult) -> Void) {
        
        // URL Parameters
        let methodParameters = [
            GoogleBooksParameterKeys.Query: searchTerm,
            GoogleBooksParameterKeys.Results: GoogleBooksParameterValues.maxResults,
            GoogleBooksParameterKeys.APIKey: GoogleBooksAPIKey.APIKey
        ]
        
        let request = NSMutableURLRequest(url: googleBooksURLFromParameters(methodParameters))
        
        session.dataTask(with: request as URLRequest) { data, response, error in
            
            // Any errors -> failure
            guard let parsedResult = self.getResult(data: data, response: response, error: error) else {
                completionHandler(.failure)
                return
            }
            
            // No search results -> nothingFound
            guard let searchResult = parsedResult[GoogleBooksAPI.GoogleBooksResponseKeys.Items] as? [[String:AnyObject]] else {
                completionHandler(.nothingFound)
                return
            }
            
            // Create book list of search results
            BookLibrary.shared.books = createListOfBooks(searchResult)
            completionHandler(.success)
            
        }.resume()
        
    }
    
    // Get the image data for a specified URL
    func getBookImage(for url: String, completionHandler: @escaping (_ imageData: Data?) -> Void) {
        
        // Valid URL?
        guard let imageURL = URL(string: url) else {
            completionHandler(nil)
            return
        }
        
        // Try to get the Image Data
        session.dataTask(with: imageURL) {data, _, _ in
            completionHandler(data)
        }.resume()
        
    }
    
    // MARK: - Helper functions
    // Create Google Books Search URL from Parameters
    private func googleBooksURLFromParameters(_ parameters: [String:String]) -> URL {
        
        var components = URLComponents()
        components.scheme = GoogleBooksURL.APIScheme
        components.host = GoogleBooksURL.APIHost
        components.path = GoogleBooksURL.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    // Given raw JSON, return a usable Foundation object
    private func convertData(_ data: Data?) -> AnyObject? {
        
        guard let data = data else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
    }
    
    // Return the parsed Result if no errors occured
    private func getResult(data: Data?, response: URLResponse?, error: Error?) -> [String: AnyObject]? {
        
        guard error == nil else {
            return nil
        }
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            return nil
        }
        guard let parsedResult = convertData(data) as? [String: AnyObject] else {
            return nil
        }
        
        return parsedResult
    }
}
