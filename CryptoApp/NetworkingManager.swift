//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Rahul Rai on 17/11/24.
//

import Foundation
import Combine



class NetworkingManager {
    
    enum  NetworkingError: LocalizedError{
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[😫] Bad Response from URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured"
            }
        }
        
    }

    
    
    // Why a static func? Well when we call download, we dont need to initialize the NetworkingManager class if we use static keyword, else we need to initialize then class then use it
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
//            throw URLError(.badServerResponse)
            throw NetworkingError.badURLResponse(url: url)
        }
        
        return output.data
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()  // Earlier we were using a complicated return type of URL Session, rather thatn doing that use .eraseToAnyPublisher to convert the retrun type to AnyPublisher<Data, any Error>
    }
    
     
    
    
    static func handleCompletion(completion : Subscribers.Completion<any Error>){
            switch completion{
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
    }
}
