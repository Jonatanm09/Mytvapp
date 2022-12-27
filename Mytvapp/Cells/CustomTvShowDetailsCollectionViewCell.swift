//
//  CustomTvShowDetailsCollectionViewCell.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 23/12/22.
//

import UIKit

class CustomTvShowDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castImgView: UIImageView!
    @IBOutlet weak var castSubtitleLbl: UILabel!
    @IBOutlet weak var castNameLbl: UILabel!
    
    func setDataValues(castName: String, castSubtitle: String) {
        castNameLbl.text = castName
        castSubtitleLbl.text = castSubtitle
    }
}
