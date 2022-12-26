//
//  TvShowsCollectionViewController.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 22/12/22.
//

import UIKit
import Alamofire

class TvShowsCollectionViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var customCollectionView: UICollectionView!
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    var listCategorysText = ["Populares", "Mejor calificadas", "Al aire hoy", "en Tv"]
    var listCategoryKeys = [ "popular", "top_rated", "airing_today", "on_the_air" ]
    var movies: [Show]!
    
    override func viewDidLoad() {
        getTvshows(category: listCategoryKeys.first!)
        self.filterTextField.text = listCategorysText.first
        super.viewDidLoad()
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
        self.pickerView.isHidden = true
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "log Out", style: .plain, target: self, action: #selector(back(sender:)))
        newBackButton.tintColor = UIColor.white
        newBackButton.image = UIImage(named: "arrowshape.turn.up.left")
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    func getTvshows(category: String) {
        getMoviesRequest(withMovieCategory: category) { Movies in
            self.movies = Movies.all
            self.customCollectionView.reloadData()
        } failure: { Error in
            displayAlert(withTitle: "Error", message: "Hubo un error inesperado", controller: self)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.filterTextField {
            self.pickerView.isHidden = false
        }
        
        self.filterTextField.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listCategorysText.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listCategorysText[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.filterTextField.text = self.listCategorysText[row]
        self.pickerView.isHidden = true
        getTvshows(category: self.listCategoryKeys[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont.systemFont(ofSize: 12)
        label.text =  listCategorysText[row]
        label.textAlignment = .center
        return label
    }
    
    @objc func back(sender: UIBarButtonItem) {
        showSimpleAlert(controller: self) {(_: UIAlertAction!) in
            Session.shared.dispose()
            self.navigationController?.popViewController(animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination : TvShowDetailsViewController = segue.destination as! TvShowDetailsViewController
        destination.programId = sender as! Int
    }
}

extension TvShowsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.count ?? 0    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CustomTvShowCollectionViewCell
        let show = movies[indexPath.row]
        getImages(imageUrlPath: show.photo, imgType: ImgTypes.medium) { img in
            cell.imgView.image = img
        }
        cell.setLabel(title: show.title, date: show.releaseDate, porcentage: "\(show.calification)")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailSegue", sender: movies[indexPath.row].id)
    }
    
}

extension TvShowsCollectionViewController: UICollectionViewDelegate {
    
}

