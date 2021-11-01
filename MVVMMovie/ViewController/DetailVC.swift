//
//  DetailVC.swift
//  MVVMMovie
//
//  Created by Bui Chung on 29/10/2021.
//

import UIKit
import SnapKit
import Kingfisher

class DetailVC: UIViewController {
    var coordinator: AppCoordinator?
    private var viewModel:DetailViewModel!
    
    @IBOutlet weak var firstStack: UIStackView!
    @IBOutlet weak var secondStack: UIStackView!
    @IBOutlet weak var thirdStack: UIStackView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblLength: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReviewNum: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblScoreNum: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblActors: UILabel!
    
    @IBOutlet weak var lblDirectorSub: UILabel!
    @IBOutlet weak var lblWriterSub: UILabel!
    @IBOutlet weak var lblActorsSub: UILabel!
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var txtPlot: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    
    static func instantiate(viewModel:DetailViewModel) -> DetailVC {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseData(movie: viewModel.movie)
        layoutUI()
    }
    
    func parseData(movie:Movie) {
        self.title = movie.Title
        imgView.kf.setImage(with: movie.Poster)
        lblYear.text = movie.Year
        lblTitle.text = ""
        txtPlot.text = movie.Plot
        lblCategory.text = movie.type
        lblLength.text = movie.Runtime
        lblRating.text = movie.imdbRating
        lblScoreNum.text = movie.imdbRating
        lblReviewNum.text = movie.imdbVotes
        lblPopularity.text = movie.Metascore
        lblActors.text = movie.Actors
        lblWriter.text = movie.Writer
        lblDirector.text = movie.Director
    }
    
    func layoutUI() {
        let paddingNormal = 8
        viewHeader.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(self.view).multipliedBy(0.3)
        }
        
        imgView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        lblYear.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(paddingNormal)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.left.equalTo(self.lblYear)
            make.bottom.equalTo(self.lblYear.snp.top)
        }
        
        firstStack.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(paddingNormal)
            make.top.equalTo(self.viewHeader.snp.bottom).offset(paddingNormal*2)
        }

        txtPlot.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(paddingNormal)
            make.top.equalTo(self.firstStack.snp.bottom).offset(paddingNormal*2)
            make.height.equalToSuperview().multipliedBy(0.18)
        }
        
        secondStack.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(paddingNormal)
            make.top.equalTo(self.txtPlot.snp.bottom).offset(paddingNormal*2)
//            make.height.equalToSuperview().multipliedBy(0.06)
        }
        thirdStack.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(paddingNormal)
            make.top.equalTo(self.secondStack.snp.bottom).offset(paddingNormal*2)
//            make.height.equalToSuperview().multipliedBy(0.2)
        }
        let ratioForLable = 0.2
        lblDirectorSub.snp.makeConstraints { make in
            make.width.equalTo(self.view).multipliedBy(ratioForLable)
        }
        lblWriterSub.snp.makeConstraints { make in
            make.width.equalTo(self.view).multipliedBy(ratioForLable)
        }
        lblActorsSub.snp.makeConstraints { make in
            make.width.equalTo(self.view).multipliedBy(ratioForLable)
        }
    }
}
