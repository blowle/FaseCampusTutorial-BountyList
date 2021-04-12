//
//  BountyViewController.swift
//  BountyList
//
//  Created by Dev on 2021/04/12.
//

import UIKit

class BountyViewController: UIViewController {
    
    // MVVM
    
    // Model
    // - BountyInfo
    // > BountyInfo 만들자
    
    // View
    // - ListCell
    // > ListCell 필요한 정보를 ViewModel한테서 받아야겠다.
    // > ListCell은 ViewModel로 부터 받은 정보로 뷰 업데이트 하기.

    // ViewModel
    // - BountyViewModel
    // > BountyViewModel 만들고, 뷰레이어에서 필요한 메소드 만드릭.
    // > 모델 가지고 있기 ..
    
    let viewModel = BountyViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController에게 데이터를 줄 작업
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
                vc?.viewModel.update(model:  viewModel.bountyInfo(at: index))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension BountyViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell else { return UICollectionViewCell() }
        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
        cell.update(info: bountyInfo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let testAreaHeight: CGFloat = 65
        let width: CGFloat = (collectionView.bounds.width - itemSpacing) / 2
        let height: CGFloat = width * 10/7 + testAreaHeight
        
        return CGSize(width: width, height: height)
    }
    
    
}

class ListCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    
    func update(info: BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
    
}

class BountyViewModel {
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 3300000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 4400000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "robin", bounty: 1600000),
        BountyInfo(name: "sanji", bounty: 80000000),
        BountyInfo(name: "zoro", bounty: 7700000)
    ]
    
    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }
    
    var sortedList: [BountyInfo] {
        let sortedList = bountyInfoList.sorted {
            prev, next in
            return prev.bounty > next.bounty
        }
        
        return sortedList
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
    
}
