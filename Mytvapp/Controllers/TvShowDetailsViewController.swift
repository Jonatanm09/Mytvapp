//
//  TvShowDetailsViewController.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 23/12/22.
//

import UIKit

class TvShowDetailsViewController: UIViewController {
    
    let cellIdentifier = "showDetailCell"
    var programId = 0
    
    @IBOutlet weak var postImgView: UIImageView!
    @IBOutlet weak var showDetailCollectionView: UICollectionView!
    @IBOutlet weak var showLbl: UILabel!
    @IBOutlet weak var showDetailLbl: UILabel!
    @IBOutlet weak var creatorLbl: UILabel!
    @IBOutlet weak var seasonLbl: UILabel!
    @IBOutlet weak var epsoidesLbk: UILabel!
    
    override func viewDidLoad() {
        self.showDetailCollectionView.delegate = self
        self.showDetailCollectionView.dataSource = self
        setPostImg(imgUrl: "/iHSwvRVsRyxpX7FE7GbviaDvgGZ.jpg")
        super.viewDidLoad()
    }
    
    
    func setPostImg(imgUrl: String) {
        getImages(imageUrlPath: "") { img in
            self.postImgView.image = img
            self.view.layoutSubviews()
        }
    }
}

extension TvShowDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CustomTvShowDetailsCollectionViewCell
        
        cell.setDataValues(castName: "Tom Ellis", castSubtitle: "Lucifer Morningstar", img: UIImage(imageLiteralResourceName: "loki"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension TvShowDetailsViewController: UICollectionViewDelegate {
    
}
