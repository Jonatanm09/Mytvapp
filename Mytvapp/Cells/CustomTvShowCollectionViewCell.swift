//
//  CustomTvShowCollectionViewCell.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 22/12/22.
//

import UIKit

class CustomTvShowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var porcentajeLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    func setLabel(title:String, date: String, porcentage: String) {
        circleView.layer.cornerRadius = circleView.layer.bounds.width / 2
        circleView.clipsToBounds = true
        titleLbl.text = title
        descriptionLbl.text = date
        porcentajeLbl.text = porcentage
       }
}
