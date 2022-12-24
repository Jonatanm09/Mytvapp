//
//  TvShowDetailsViewController.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 23/12/22.
//

import UIKit

class TvShowDetailsViewController: UIViewController {
    
    let cellIdentifier = "showDetailCell"
    
    @IBOutlet weak var showDetailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        self.showDetailCollectionView.delegate = self
        self.showDetailCollectionView.dataSource = self
        super.viewDidLoad()
    }
}

extension TvShowDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CustomTvShowDetailsCollectionViewCell
        
        cell.setDataValues(castName: "PEdro", castSubtitle: "Loco", img: UIImage(imageLiteralResourceName: "loki"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailSegue", sender: self)
    }
    
}

extension TvShowDetailsViewController: UICollectionViewDelegate {
    
}
