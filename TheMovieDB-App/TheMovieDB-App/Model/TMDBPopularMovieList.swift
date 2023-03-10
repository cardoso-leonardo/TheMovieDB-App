//
//  TMDBPopularMovieList.swift
//  TheMovieDB-App
//
//  Created by Leonardo Cardoso on 24/01/23.
//

import Foundation

struct TMDBPopularMovieList: Codable {
    let page: Int
    let results: [Movie]
    let total_pages: Int?
}

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
