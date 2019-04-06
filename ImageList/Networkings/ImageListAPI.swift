//
//  ImageListAPI.swift
//  ImageList
//
//  Created by Xie Liwei on 06/04/2019.
//  Copyright © 2019 Xie Liwei. All rights reserved.
//

import Foundation
import Moya

typealias Params = [String: Any]

public enum ImageListAPI {
    case getImages
}

extension ImageListAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://my-json-server.typicode.com/mdislam/rest_service/")!
    }
    
    public var path: String {
        switch self {
        case .getImages:
            return "data/"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getImages:
            return .get
        }
    }
    
    public var sampleData: Data {
        return stubbedResponse("DefaultSuccess")
    }
    
    public var task: Task {
        switch self {
        case .getImages:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
    
func stubbedResponse(_ filename: String) -> Data! {
    class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}
