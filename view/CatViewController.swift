//
//  CatViewController.swift
//  CatApp
//
//  Created by mai nguyen on 6/22/23.
//

import UIKit

class CatViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var catVM = CatViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CatCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: CatCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemPink

        collectionView.setCollectionViewLayout(layout(), animated: true)
        
        catVM.getListOfCatS { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 30)/2, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }

   
}

extension CatViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catVM.numberOfCats()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCollectionViewCell.identifier, for: indexPath) as? CatCollectionViewCell {
            
            
            let thisCat  = catVM.catResponses?[indexPath.item]
            
            cell.updateCell(cat: thisCat)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let catDetailVC = storyboard.instantiateViewController(withIdentifier: CatDetailViewController.identifier) as? CatDetailViewController
        
        
        let thiscat = catVM.catResponses?[indexPath.item]
        catDetailVC?.cat = thiscat
        
        present(catDetailVC!, animated: true)
    }
   
    
}
