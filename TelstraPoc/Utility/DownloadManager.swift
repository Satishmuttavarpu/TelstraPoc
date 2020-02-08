//
//  Constant.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 08/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import UIKit

class DownloadManager: NSObject {
    
    static public let downloadmanager = DownloadManager()
    
    public override init() {
        
    }
    
    public func downloadImage(imageUrl:String, completion: @escaping (UIImage?)->()) {
        let url = URL(string: imageUrl)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let imgData = data else {
               // print("No data")
                return
            }
            let image = UIImage(data: imgData)
            completion(image)
        }).resume()
    }

}
