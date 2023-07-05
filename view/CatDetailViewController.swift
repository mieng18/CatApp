//
//  CatDetailViewController.swift
//  CatApp
//
//  Created by mai nguyen on 6/22/23.
//

import UIKit
import Foundation

class CatDetailViewController: UIViewController {
    
    static let identifier = "CatDetailViewController"

    @IBOutlet weak var catdetailImage: UIImageView!
    
    @IBOutlet weak var catDetailLabel: UILabel!
    
    
    var cat: CatModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        
        if  cat?.url != nil || cat?.id != nil {
            catdetailImage.downloadImage(urlString: cat?.url  ?? "")
            catDetailLabel.text = cat?.id ?? ""

        }
    }
}
