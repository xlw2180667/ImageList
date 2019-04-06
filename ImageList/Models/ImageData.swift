//
//  ImageData.swift
//  ImageList
//
//  Created by Xie Liwei on 06/04/2019.
//  Copyright © 2019 Xie Liwei. All rights reserved.
//

import Foundation

class ImageData: Codable {
    let baseUrl: String
    let apiPath: String
    let extensions: [String]
    let fileSizes: [String]
    enum CodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case apiPath = "api_path"
        case extensions
        case fileSizes = "file_sizes"
    }
}
