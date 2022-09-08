//
//  PhotoCollectionViewCell.swift
//  TableView
//
//  Created by Illya Gurkov on 7.09.22.
//

import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var photoImage: UIImageView!

    var photo: JSON!

    func configureCell() {
        photoImage.image = #imageLiteral(resourceName: "images")
    }

    func getThumbnail() {
        if let thumbnailURL = photo["thumbnailUrl"].string {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailURL) {
                activityIndicator.stopAnimating()
                photoImage.image = image
            } else {
                AF.request(thumbnailURL).responseImage { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.activityIndicator.stopAnimating()
                        self?.photoImage.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: thumbnailURL)
                    }
                }
            }
        }
    }
}
