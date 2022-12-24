//
//  TvShowsCollectionViewController.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 22/12/22.
//

import UIKit

class TvShowsCollectionViewController: UIViewController {
    
    @IBOutlet weak var customCollectionView: UICollectionView!
    
    private let category = "popular"
    var movies: [Show]!
    
    override func viewDidLoad() {
        getTvshows()
        super.viewDidLoad()
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
    }
    
    func getTvshows() {
        getMoviesRequest(withMovieCategory: category) { Movies in
            self.movies = Movies.all
            self.customCollectionView.reloadData()
        } failure: { Error in
            displayAlert(withTitle: "Error", message: "Hubo un error inesperado", controller: self)
        }
        
    }
}

extension TvShowsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.count ?? 0    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CustomTvShowCollectionViewCell
        
        cell.setLabel(title: movies[indexPath.row].title, date: movies[indexPath.row].releaseDate, porcentage: "\(movies[indexPath.row].calification)")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailSegue", sender: self)
    }
    
}

extension TvShowsCollectionViewController: UICollectionViewDelegate {
    
}
