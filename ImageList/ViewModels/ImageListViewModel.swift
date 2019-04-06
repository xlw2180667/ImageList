//
//  ImageListViewModel.swift
//  ImageList
//
//  Created by Xie Liwei on 06/04/2019.
//  Copyright © 2019 Xie Liwei. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ImageListViewModelProtocol {
    //Input
    var provider: ImageListService? { get }
    
    //Output
    var datasource: BehaviorRelay<[Image]> { get }
    func fetchImageData()
}

class ImageListViewModel: ImageListViewModelProtocol {
    //Input
    var provider: ImageListService?
    
    //Output
    let datasource = BehaviorRelay<[Image]>(value: [Image]())
    fileprivate let bag = DisposeBag()
    
    init(provider: ImageListService?) {
        self.provider = provider
    }
    
    func fetchImageData() {
        provider?.getImages()
            .subscribe(onNext: { imageData in
                self.generateDataSource(imageData: imageData)
            }, onError: { _ in
                
            }).disposed(by: bag)
    }
    
    func generateDataSource(imageData: ImageData) {
        var images = [Image]()
        let baseUrl = imageData.baseUrl
        let path = imageData.apiPath
        for format in imageData.extensions {
            for size in imageData.fileSizes {
                let prefix = format == "png" ? "Sample-png-image" : "Sample-jpg-image"
                let urlString = String(format: "%@%@/%@-%@.%@", baseUrl, path, prefix, size, format)
                if let url = URL(string: urlString) {
                    let image = Image(url: url)
                    images.append(image)
                }
            }
        }
        datasource.accept(images)
    }
    
}
