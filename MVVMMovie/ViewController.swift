//
//  ViewController.swift
//  MVVMMovie
//
//  Created by Bui Chung on 29/10/2021.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class ViewController: UIViewController {
    private var viewModel:PosterListViewModel!
    private var bag = DisposeBag()
    
    var coordinator: AppCoordinator?
    
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    static func instantiate(viewModel:PosterListViewModel) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configView()
        bindData()
    }
    
    let margin: CGFloat = 10
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0,  y: 0, width:300, height: 20))
    
    func configView() {
        searchBar.placeholder = "Your placeholder"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        do {
            searchBar.text = try viewModel.query.value()
        } catch  {
            
        }
        
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(1500), scheduler: MainScheduler.instance)
            .debug("debounce")
            .bind(to: viewModel.query)
            .disposed(by: bag)
        
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: 2,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        )
        
        posterCollectionView.collectionViewLayout = columnLayout
        posterCollectionView.contentInsetAdjustmentBehavior = .always
    }

    func bindData() {
        viewModel.items.bind(to: posterCollectionView.rx.items(cellIdentifier: "postCell", cellType: PosterCell.self)) { row, item, cell in
            cell.title.text = item.title
            cell.imageView.kf.setImage(with: item.poster)
        }.disposed(by: bag)

        posterCollectionView.rx.modelSelected(MoviePoster.self).flatMap {
            self.viewModel.fetchDetailFromService(movieID: $0.imdbID)
        }
        .subscribe { [weak self] movie in
            self?.coordinator?.goToDetail(model: movie)
        }.disposed(by: bag)
        
        viewModel.query
            .flatMap { self.viewModel.fetchItemsFromService(query: $0)}
            .debug("viewModel.query")
            .subscribe { self.viewModel.items.onNext($0) }
            .disposed(by: bag)

    }
    
    func debugDetail() {
        viewModel.items.map { $0.first! }.flatMap {
            self.viewModel.fetchDetailFromService(movieID: $0.imdbID)
        }
        .subscribe { [weak self] movie in
            self?.coordinator?.goToDetail(model: movie)
        }.disposed(by: bag)

    }
}

