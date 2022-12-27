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
    var showDetail: ShowDetail!
    var castArray: [Credits]!
    
    @IBOutlet weak var postImgView: UIImageView!
    @IBOutlet weak var showDetailCollectionView: UICollectionView!
    @IBOutlet weak var showLbl: UILabel!
    @IBOutlet weak var showDetailLbl: UILabel!
    @IBOutlet weak var creatorLbl: UILabel!
    @IBOutlet weak var seasonLbl: UILabel!
    @IBOutlet weak var epsoidesLbk: UILabel!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.showDetailCollectionView.delegate = self
        self.showDetailCollectionView.dataSource = self
        if Session.shared.getShowDetail() != nil {
            let showFound = Session.shared.getShowDetail()!.first(where: { show in
                show.id == programId
            })
            if showFound != nil {
                self.showDetail = showFound!
                self.setValues(show: self.showDetail)
            }else{
                getTvshows(showId: programId)
            }
        }else{
            getTvshows(showId: programId)
            
        }
        getCast(showID: programId)
        super.viewDidLoad()
    }
    
    
    func setPostImg(imgUrl: String, imgType: ImgTypes) {
        getImages(imageUrlPath: imgUrl, imgType: imgType) { img in
            self.postImgView.image = img
            self.view.layoutSubviews()
        }
    }
    
    func getCast(showID: Int){
        getCredits(withId: showID) { cast in
            self.castArray = cast.cast
            self.showDetailCollectionView.reloadData()
        } failure: { _ in
        }
    }
    
    func getTvshows(showId: Int) {
        getShowsDetailsRequest(withId: showId, success: { shows in
            self.showDetail = shows
            Session.shared.saveShowDetail(showDetail: self.showDetail)
            self.setValues(show: self.showDetail)
        }, failure: { error in
        })
    }
    
    func setValues (show: ShowDetail){
        setPostImg(imgUrl: show.photo ?? "", imgType: ImgTypes.large)
        showLbl.text = show.name
        showDetailLbl.text = show.overview!.isEmpty ? "N/A" : show.overview
        seasonLbl.text = "Temporada: \(show.seasons!.last!.seasonNumber!)"
        let subString = show.airDate!.prefix(4)
        epsoidesLbk.text = subString + " | \(show.seasons!.last!.episodseCount!) episodios"
        creatorLbl.text = show.creators?.count != 0 ? creatorString(creator: show.creators!) : "N/A"
        
    }
    
    func creatorString(creator: [Creators]) -> String {
        var creatorString = ""
        for creatorName in creator {
            creatorString +=   " • " + creatorName.name!
        }
        return "Creadores: " + creatorString.suffix(creatorString.count - 2 )
    }
    
}

extension TvShowDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.castArray?.count ?? 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CustomTvShowDetailsCollectionViewCell
        if castArray == nil {
            cell.setDataValues(castName: "N/A", castSubtitle: "N/A")
        } else{
            let cast =  castArray[indexPath.row]
            getImages(imageUrlPath: cast.profilePhoto ?? "", imgType: ImgTypes.small) { img in
                cell.castImgView.image = img
            }
            cell.setDataValues(castName: cast.name ?? "N/A", castSubtitle: cast.characterName ?? "N/A")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension TvShowDetailsViewController: UICollectionViewDelegate {
    
}
