//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Rahul Rai on 14/11/24.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [Coin] = []
//    var cancellables = Set<AnyCancellable>()
    var coinSubscription: AnyCancellable?
    
    init(){
        getCoins()
    }
    
    private func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else{
            return }
        
        coinSubscription =  NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returnedCoins) in
                self?.allCoins = returnedCoins   // Dont create a strong ref, becoz in case we need to dealloacte the class, we wont be ablt to then. SO lets make it weak self
                self?.coinSubscription?.cancel()
            })

        // Not refactored code of network call
        /*
        coinSubscription =  URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: {[weak self] (returnedCoins) in
                self?.allCoins = returnedCoins   // Dont create a strong ref, becoz in case we need to dealloacte the class, we wont be ablt to then. SO lets make it weak self
                self?.coinSubscription?.cancel()
            }
         */

        
    }
    
}