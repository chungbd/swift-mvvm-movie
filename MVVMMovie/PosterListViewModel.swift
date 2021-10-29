//
//  MovieViewModel.swift
//  MVVMMovie
//
//  Created by Bui Chung on 29/10/2021.
//

import Foundation
import RxSwift

struct PosterListViewModel {
    let items = PublishSubject<[MoviePoster]>()
    
    let movieService:MovieService
    let query = BehaviorSubject<String>(value: "Marvel")
    
    init(service:MovieService = MovieService()) {
        movieService = service
    }
    
    func fetchItemsFromService(query:String) -> Observable<[MoviePoster]> {
        return movieService.fetchPosters(title: query)
    }
    
    func fetchDetailFromService(movieID:String) -> Observable<Movie> {
        return movieService.fetchDetailMovie(movieID: movieID)
    }
}
