//
//  AppCell.swift
//  SearchApp
//
//  Created by ㅇ오ㅇ on 2021/03/26.
//

import UIKit
import Cosmos

class AppCell: UICollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var ratingCount: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    
    @IBOutlet weak var screenStackView: UIStackView!
    @IBOutlet weak var screenStackViewFirstImage: UIImageView!
    @IBOutlet weak var screenStackViewSecondImage: UIImageView!
    @IBOutlet weak var screenStackViewThirdImage: UIImageView!
    
    @IBOutlet weak var twoScreenStackView: UIStackView!
    @IBOutlet weak var twoScreenStackViewFirstImage: UIImageView!
    @IBOutlet weak var twoScreenStackViewSecondImage: UIImageView!
    
    
    var data: Results? {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true // 재사용이 되었을때 width 값이 변경되는 것을 방지!!
        contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height/2).isActive = true // 재사용이 되었을때 height 값이 변경되는 것을 방지!!
        
        [icon, twoScreenStackViewFirstImage, twoScreenStackViewSecondImage, screenStackViewFirstImage, screenStackViewSecondImage, screenStackViewThirdImage].forEach {
            guard let one = $0 else { return }
            one.layer.cornerRadius = 10
        }
        guard let button = downloadButton else { return }
        button.layer.cornerRadius = 15
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        icon.image = nil
        twoScreenStackViewFirstImage?.image = nil
        twoScreenStackViewSecondImage?.image = nil
        
        screenStackView?.isHidden = false
        twoScreenStackView?.isHidden = false
        screenStackViewFirstImage?.image = nil
        screenStackViewSecondImage?.image = nil
        screenStackViewThirdImage?.image = nil
        
        screenStackViewSecondImage?.isHidden = false
        screenStackViewThirdImage?.isHidden = false
    }
    
    private func configure() {
        let viewModel = SearchViewModel(result: data)
        
        icon?.setImageUrl(viewModel.iconImageString)

        title?.text = viewModel.appMainTitleString
        
        subTitle?.text = viewModel.appMainTitleString
        subTitle?.textColor = viewModel.userRatingCountTextColor
        
        ratingCount?.text = viewModel.userRatingCount
        ratingCount?.textColor = viewModel.userRatingCountTextColor

        starRating?.rating = viewModel.ratingStarCount
        
        if viewModel.screenShot.count == 2 {
            screenStackView?.isHidden = true
            twoScreenStackViewFirstImage?.setImageUrl(viewModel.screenShot[0])
            twoScreenStackViewSecondImage?.setImageUrl(viewModel.screenShot[1])
        } else if viewModel.screenShot.count == 1 {
            twoScreenStackView?.isHidden = true
            screenStackViewFirstImage?.setImageUrl(viewModel.screenShot[0])
            screenStackViewSecondImage?.isHidden = true
            screenStackViewThirdImage?.isHidden = true
        } else {
            twoScreenStackView?.isHidden = true
            screenStackViewFirstImage?.setImageUrl(viewModel.screenShot[0])
            screenStackViewSecondImage?.setImageUrl(viewModel.screenShot[1])
            screenStackViewThirdImage?.setImageUrl(viewModel.screenShot[2])
        }
    }
    
}
