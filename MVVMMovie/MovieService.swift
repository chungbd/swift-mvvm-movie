//
//  MovieService.swift
//  MVVMMovie
//
//  Created by Bui Chung on 29/10/2021.
//

import Foundation
import RxSwift

class MovieService {
    func fetchPosters(title:String) -> Observable<[MoviePoster]> {
        return Observable.create { observer -> Disposable in
            let url = URL(string: "http://www.omdbapi.com/?apikey=b9bd48a6&s=\(title)&type=movie")!
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let rdata = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                
                    
                do {
                    let json = try JSONSerialization.jsonObject(with: rdata, options: [])
                    
                    guard let json = json as? [String: Any], let searchJson = json["Search"] as? [Any] else {
                        observer.onNext([])
                        
                        return
                    }
                    let posters = try JSONDecoder().decode([MoviePoster].self, from: try JSONSerialization.data(withJSONObject: searchJson, options: .prettyPrinted))
                    observer.onNext(posters)
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchDetailMovie(movieID:String ) -> Observable<Movie> {
        return Observable.create { observer -> Disposable in
            let url = URL(string: "http://www.omdbapi.com/?apikey=b9bd48a6&i=\(movieID)&plot=full")!
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let rdata = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                
                    
                do {

                    let movie = try JSONDecoder().decode(Movie.self, from: rdata)
                    observer.onNext(movie)
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
