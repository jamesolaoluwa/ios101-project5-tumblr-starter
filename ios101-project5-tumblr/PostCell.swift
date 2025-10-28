//
//  PostCell.swift
//  ios101-project5-tumblr
//
//  Created by Olaoluwa James-Owolabi on 10/28/25.
//

import UIKit

class PostCell: UITableViewCell {

    // Allow outlets if used in storyboard
    
//    @IBOutlet weak var postImageView: UIImageView!
//    
//    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if postImageView != nil && summaryLabel != nil {
            configureUI()
        }
    }


        override func prepareForReuse() {
            super.prepareForReuse()
            postImageView.image = nil
            summaryLabel.text = nil
        }

        private func configureUI() {
            postImageView.contentMode = .scaleAspectFill
            postImageView.clipsToBounds = true
            postImageView.backgroundColor = UIColor(white: 0.95, alpha: 1)

            summaryLabel.numberOfLines = 0
            summaryLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            summaryLabel.textColor = .black

            contentView.backgroundColor = .white
        }

}
