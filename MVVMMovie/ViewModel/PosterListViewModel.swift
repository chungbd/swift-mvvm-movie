//
//  MovieViewModel.swift
//  MVVMMovie
//
//  Created by Bui Chung on 29/10/2021.
//

import Foundation
import RxSwift

struct PosterListViewModel {
    var coordinator: AppCoordinator?
    private var disposeBag = DisposeBag()
    
    let items = PublishSubject<[MoviePoster]>()
    let currentMovie = BehaviorSubject<Movie?>(value: nil)
    let movieService:MovieService
    
    let query = BehaviorSubject<String>(value: "Marvel")
    
    init(coordinator:AppCoordinator, service:MovieService = MovieService()) {
        movieService = service
        self.coordinator = coordinator
        setupBinding()
    }
    
    func setupBinding() {
        currentMovie.debug("currentMovie").subscribe(onNext: { movie in
            if let rMovie = movie {
                coordinator?.goToDetail(model: rMovie)
            }
        })
        .disposed(by: disposeBag)
    }
    
    func debugDetail() {
        items.map { $0.first! }.flatMap {
            self.fetchDetailFromService(movieID: $0.imdbID)
        }
        .subscribe { movie in
            coordinator?.goToDetail(model: movie)
        }.disposed(by: disposeBag)
    }
    
    func fetchItemsFromService(query:String) -> Observable<[MoviePoster]> {
        return movieService.fetchPosters(title: query)
    }
    
    func fetchDetailFromService(movieID:String) -> Observable<Movie> {
        return movieService.fetchDetailMovie(movieID: movieID)
    }
}
