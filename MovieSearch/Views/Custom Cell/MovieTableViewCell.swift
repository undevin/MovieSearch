//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Devin Flora on 1/29/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    // MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    override func prepareForReuse() {
        movieTitleLabel.text = ""
        movieRatingLabel.text = ""
        movieDescriptionLabel.text = ""
        movieImageView.image = UIImage(named: "")
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        MovieController.fetchMovieImage(movie: movie) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.movieImageView.image = image
                    self.movieTitleLabel.text = movie.originalTitle
                    self.movieRatingLabel.text = "Rating: \(movie.voteAverage)"
                    self.movieDescriptionLabel.text = movie.overview
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}//End of Class
