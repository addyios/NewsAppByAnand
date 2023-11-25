//
//  NewsTableViewCell.swift
//  NewsAppByAnand
//
//  Created by APPLE on 25/11/23.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var source_lbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var news_img: UIImageView!
    
    @IBOutlet weak var news_description_lbl: UILabel!
    
    @IBOutlet weak var auth_create_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with article: Article) {
        titleLbl.text = article.title
        news_img.sd_setImage(with: URL(string: article.urlToImage ?? ""), placeholderImage: UIImage(named: "Image_not_available"))
        news_description_lbl.text = article.description
        source_lbl.text = article.source?.name
        auth_create_lbl.text = "\(article.author ?? "") - \(article.publishedAt ?? "")"
    }
    
}
