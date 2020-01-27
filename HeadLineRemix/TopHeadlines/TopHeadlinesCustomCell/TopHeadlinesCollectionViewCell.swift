//
//  TopHeadlinesCollectionViewCell.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/20/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import UIKit

class TopHeadlinesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView?
    @IBOutlet weak var title: UILabel?
    var article: TopHeadlinesDetailViewData?{
        didSet{
            title?.text = article?.title ?? "Error value"
            thumbnailImage?.setImage(from: article?.url ?? "")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
