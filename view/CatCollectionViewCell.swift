//
//  CatCollectionViewCell.swift
//  CatApp
//
//  Created by mai nguyen on 6/22/23.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var catLabel: UILabel!
    static let identifier = "CatCollectionViewCell"
    
    var catModel: CatModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func updateCell(cat: CatModel?){
        catImage.downloadImage(urlString: cat?.url ?? "")
        catLabel.text = cat?.id
    }
    
    
}
