//
//  ImageListService.swift
//  ImageList
//
//  Created by Xie Liwei on 06/04/2019.
//  Copyright © 2019 Xie Liwei. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol ImageListServiceProtocol {
    func getImages() -> Observable<ImageData>
}

class ImageListService: ImageListServiceProtocol {
    private var provider: MoyaProvider<ImageListAPI>
    
    init(provider: MoyaProvider<ImageListAPI> = MoyaProvider<ImageListAPI>(plugins: [NetworkLoggerPlugin(verbose: true,
                                                                                                     responseDataFormatter: JSONResponseDataFormatter)]), stubbed: Bool = false) {
        
        if (stubbed) {
            self.provider = MoyaProvider(stubClosure: MoyaProvider.immediatelyStub)
        } else {
            self.provider = provider
        }
    }
    
    static func newStubbingNetworking() -> ImageListService {
        return ImageListService.init(stubbed: true)
    }
    
    func void<T>(_: T) {
        return Void()
    }
    
    func getImages() -> Observable<ImageData> {
        return provider.rx.request(.getImages)
               .filterSuccessfulStatusCodes()
               .map(ImageData.self)
               .asObservable()
    }

}

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        print("Error parsing json")
        return data // fallback to original data if it can't be serialized.
    }
}
