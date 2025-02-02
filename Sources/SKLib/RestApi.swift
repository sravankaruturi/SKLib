//
//  RestApi.swift
//  
//
//  Created by Sravan Karuturi on 7/22/24.
//

import Foundation

public class RestAPI {
    
    private let session: URLSession
    
    internal init(session: URLSession = .shared) {
        self.session = session
    }
    
    @MainActor public static let shared: RestAPI = RestAPI()
    
    /// Posts given data to a URL with the header fields and then calls the completion function once it is done.
    /// The completion function must be escaping since it can outlive the scope that made this call.
    /// It must also be Sendable for Concurrency reasons. -- Read more here: https://www.hackingwithswift.com/swift/5.5/sendable
    func postData(url: String, data: [String: Any], headerFields: [String: String] , completion: @Sendable @escaping (Result<Data, Error>, URLResponse?) -> Void) {
        
        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        for (key, value) in headerFields {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = jsonData
        
        let task = self.session.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print("error=\(error?.localizedDescription ?? "Unknown error")")
                completion(.failure(error!), response)
                return
            }
            
            // We complete even if the data is blank / 0 bytes.
            completion(.success(data), response)
            
        }
        task.resume()
        
    }
    
    @discardableResult
    func putFile(from fileUrl: URL, to uploadUrl: URL, headerFields: [String: String] , completion: @Sendable @escaping (Result<Void, Error>, URLResponse?) -> Void) -> URLSessionUploadTask {
    
        var request = URLRequest(url: uploadUrl)
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.uploadTask(with: request, fromFile: fileUrl) { data, response, error in
            
            // Handle the response and errors
            if let error = error {
                completion(.failure(error), response)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
#if DEBUG
                print("Upload Successful")
                print(httpResponse.statusCode)
#endif
                completion(.success(()), response)
            } else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let error = NSError(domain: "RestAPI", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to upload file with status code: \(statusCode). The response is \(String(describing: response))"])
                completion(.failure(error), response)
            }
        }
        
        task.resume()
        return task
        
    }
    
    public func fetchData(
        url: URL,
        headerFields: [String: String] = [:],
        completion: @escaping @Sendable (Result<Data, Error>, HTTPURLResponse?) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        for (key, value) in headerFields {
            request.addValue(value, forHTTPHeaderField: key)
        }
                
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("error: Unknown response type")
                completion(.failure(URLError(.unsupportedURL)), nil)
                return
            }

            if !httpResponse.isResponseOk {
                print("error: Request failed (\(httpResponse.statusCode))")
                completion(.failure(URLError(.unknown)), httpResponse)
                return
            }

            guard let data = data, error == nil else {
                print("error: \(error?.localizedDescription ?? "Unknown error")")
                completion(.failure(error!), httpResponse)
                return
            }
            
            completion(.success(data), httpResponse)
        }
        task.resume()
    }
    
}
