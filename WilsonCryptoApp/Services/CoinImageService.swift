//
//  CoinImageService.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 6/1/22.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService {
    
    @Published var image: UIImage? = nil
   private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let FileManager = LocalFileManager.instance
    private let FolderName = "Coin_Images"
    private let ImageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.ImageName = coin.id
        getCoinImage()
        
    }
    
    private func getCoinImage() {
        if let savedImage = FileManager.getImage(imageName: ImageName, FolderName: FolderName) {
            image = savedImage

            print("Retrieved image from File Manager!")
        } else {
            downloadCoinImage()
            print("Downloading Image Now....")
        }
    }
    
    private func downloadCoinImage() {
        print("Downloading Image Now")
        guard let url = URL(string:  coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage?  in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.FileManager.saveImage(image: downloadedImage, imageName: self.ImageName, FolderName: self.FolderName)
            })
    }
}
