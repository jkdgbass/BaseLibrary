//
//  File.swift
//  BaseLibrary
//
//  Created by DoHyoung Kim on 3/5/25.
//

import Foundation
import UIKit
import Photos

extension PHAsset {
    
    var image: UIImage {
        var assetImage = UIImage()
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        options.resizeMode = .none
        options.isNetworkAccessAllowed = true
        
        manager.requestImage(for: self,
                             targetSize: CGSize(width: self.pixelWidth, height: self.pixelHeight),
                             contentMode: .aspectFill,
                             options: options) { img, info in
            
            if let img = img {
                assetImage = img
            }
        }
        
        return assetImage
    }
    
    var thumbnail: UIImage {
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self,
                                  targetSize: CGSize(width: 200, height: 200),
                                  contentMode: .aspectFit,
                                  options: nil) { img, _ in
            
            if let img = img {
                thumbnail = img
            }
        }
        return thumbnail
    }
}

