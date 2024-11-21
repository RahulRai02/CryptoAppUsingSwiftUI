//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Rahul Rai on 18/11/24.
//

import SwiftUI

struct CoinImageView: View {
    
    // CoinImageView -> CoinImageViewModel -> CoinImageService 
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: Coin){
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoading{
                ProgressView()
            }else{
                Image(systemName:  "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
                
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
//
//#Preview {
//    CoinImageView(coin: dev)
//}
