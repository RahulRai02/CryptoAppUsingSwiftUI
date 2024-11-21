//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Rahul Rai on 18/11/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = true
    
    // Initialize a coin image service
    private let coin: Coin
    private let dataService : CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin){

        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
//        getImage()
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers(){
        // Subscribe to the image service
        dataService.$image
            .sink { [weak self] (_) in
                // Weather or not the image is loaded or not, set isLoading to false
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                // Set the image to the returned image
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
    
//    private func getImage(){
//
//    }
    
}
