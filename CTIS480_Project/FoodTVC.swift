//
//  FoodTVC.swift
//  CTIS480_Project
//
//  Created by Yusuf Çiftci on 29.12.2022.
//
import UIKit

typealias seeAllClosure = ((_ index: Int?) -> Void)
typealias didSelectClosure = ((_ tableIndex: Int?, _ collectionIndex: Int?) -> Void)

class FoodTVC: UITableViewCell {
    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var mLabel: UILabel!
    
    var index: Int?
    var onClickSeeAllClosure: seeAllClosure?
    var onDidSelectClosure: didSelectClosure?
    
    var meals: MealS? {
        didSet {
            mLabel.text = meals?.day
            mCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickSeeAll(_ sender: UIButton) {
        onClickSeeAllClosure?(index)
    }
}

extension FoodTVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodTV", for: indexPath) as? FoodCell else {
            return UICollectionViewCell()    // return an empty standard UITableViewCell
        }
        cell.foodLabel.text = meals?.title
        //cell.productName.text = products?.products?[indexPath.row].name
        //cell.productImage.image = UIImage(named: products?.products?[indexPath.row].imageName ?? "")
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onDidSelectClosure?(index, indexPath.row)
    }
}

