//
//  MovieController.swift
//  MovieSearch
//
//  Created by Devin Flora on 1/29/21.
//

import UIKit

class MovieController {
    
    // MARK: - Properties
    static let baseURL = URL(string: "https://api.themoviedb.org/")
    static let imageURL = URL(string: "https://image.tmdb.org/t/p/w500")
    static let apiVersionComponent = "3"
    static let searchMovieComponent = "search/movie"
    static let apiKeyComponent = "api_key"
    static let apiKey = "41940113fa128b1a98e3efe6e275debb"
    static let queryComponent = "query"
    
    // MARK: - Fetch Movie Method
    static func fetchMovieFrom(searchTerm: String, completion: @escaping (Result<[Movie],MovieError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let apiVersionURL = baseURL.appendingPathComponent(apiVersionComponent)
        let searchMovieURL = apiVersionURL.appendingPathComponent(searchMovieComponent)
        
        var components = URLComponents(url: searchMovieURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: apiKeyComponent, value: apiKey)
        let movieQuery = URLQueryItem(name: queryComponent, value: searchTerm)
        components?.queryItems = [apiQuery, movieQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("===== ERROR =====")
                print("Function: \(#function)")
                print(error)
                print("Description: \(error.localizedDescription)")
                print("===== ERROR =====")
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let movies = topLevelObject.results
                return completion(.success(movies))
            } catch {
                print("===== ERROR =====")
                print("Function: \(#function)")
                print(error)
                print("Description: \(error.localizedDescription)")
                print("===== ERROR =====")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    // MARK: - Fetch Movie Image Method
    static func fetchMovieImage(movie: Movie, completion: @escaping (Result<UIImage,MovieError>) -> Void) {
        guard let imageURL = imageURL else { return completion(.failure(.invalidURL)) }
        guard let movieImage = movie.posterPath else { return completion(.failure(.invalidURL)) }
        let finalURL = imageURL.appendingPathComponent(movieImage)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("===== ERROR =====")
                print("Function: \(#function)")
                print(error)
                print("Description: \(error.localizedDescription)")
                print("===== ERROR =====")
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            completion(.success(image))
        }.resume()
    }
}//End of Class
