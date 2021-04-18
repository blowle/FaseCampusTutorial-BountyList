//
//  DetailViewController.swift
//  BountyList
//
//  Created by Dev on 2021/04/12.
//

import UIKit

class DetailViewController: UIViewController {
    // MVVM
    
    // Model
    // - BountyInfo
    // > BountyInfo 만들자
    
    // View
    // - imgview, namelabel, bountyLabel
    // > view들은 ViewModel를 통해서 구성되기.

    // ViewModel
    // - DetailViewModel.
    // > 뷰레이어에서 필요한 메소드 만드릭.
    // > 모델 가지고 있기 ..
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    
    let viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showAnimation()
    }
    
    func prepareAnimation() {
//        nameLabelCenterX.constant = view.bounds.width
//        bountyLabelCenterX.constant = view.bounds.width
        
        nameLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
            .scaledBy(x: 3.0, y: 3.0)
            .rotated(by: 180)
        
        bountyLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
            .scaledBy(x: 3.0, y: 3.0)
            .rotated(by: 180)
        
        nameLabel.alpha = 0
        bountyLabel.alpha = 0
    }
    
    func showAnimation() {
//        nameLabelCenterX.constant = 0
//        bountyLabelCenterX.constant = 0
        
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
//        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//
//        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
       
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            self.nameLabel.transform = CGAffineTransform.identity
            self.nameLabel.alpha = 1
            
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            self.bountyLabel.transform = CGAffineTransform.identity
            self.bountyLabel.alpha = 1
        }, completion: nil)
        
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
    }
    
    
    func updateUI() {
        
        if let bountyInfo = viewModel.bountyInfo {
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

class DetailViewModel {
    var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo?) {
        bountyInfo = model
    }
}
