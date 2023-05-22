//
//  DashboardVC.swift
//  CTIS480_Project
//
//  Created by Yusuf Çiftci on 28.12.2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData


class DashboardVC: UIViewController{

    var count = 0
    var foodTitle: Array<String>!
    var foodNS: NSDictionary!
    var cal: Double!
    
    @IBOutlet var table: UITableView!
    
    let mJSONDataSource = DataSource()
    

    let context = (UIApplication.shared.delegate as! AppDelegate).MealpersistentContainer.viewContext

    
    //var imageUrl = "https://spoonacular.com/recipeImages/"
    var e: Any!
    // Create a dictionary of headers to send with the request
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "gra2")!).withAlphaComponent(1)

        print(cal)
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        mJSONDataSource.getMeal(cal: cal, col: foodCollectionView)
        
        
    }

}

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func itemsInCategory(index: Int) -> [MealS] {
        let item = mJSONDataSource.weeks[index]

        let filteredItems = mJSONDataSource.meal.filter { (record: MealS) -> Bool in
            return record.day == item
        }
        return filteredItems
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FoodCell
        let vc = storyboard?.instantiateViewController(withIdentifier: "sbDetailVc") as? DetailVC
        //vc?.mtitle = meal[indexPath.row].title
        vc?.image = cell?.foodImageView.image
        vc?.nTitle = cell?.foodLabel.text
        vc?.recipeId = Int(cell?.idLabel.text ?? String(mJSONDataSource.meal[indexPath.row].id))
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mJSONDataSource.weeks.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInCategory(index: section).count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let records: [MealS] = itemsInCategory(index: indexPath.section)
        let record = records[indexPath.row]
        
        
        let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCell
        let url = URL(string: record.image)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        cell.contentView.layer.insertSublayer(gradientLayer, at: 0)
        print(record)
        cell.foodLabel.text = record.title
        cell.idLabel.text = String(record.id)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                   
                    cell.foodImageView.image = image
                    //cell.foodImageView.layer.cornerRadius = cell.frame.height / 2
                }
            }
        }.resume()
            
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! FoodCollectionReusableView
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        //cell.contentView.layer.insertSublayer(gradientLayer, at: 0)
        headerView.layer.insertSublayer(gradientLayer, at: 0)
        headerView.mHeaderLabel.text = mJSONDataSource.weeks[indexPath.section].description.capitalized
        headerView.layer.cornerRadius = headerView.frame.height / 5
        
        
        return headerView
    }
}
    

