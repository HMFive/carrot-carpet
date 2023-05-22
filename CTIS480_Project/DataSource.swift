//
//  DataSource.swift
//  CTIS480_Project
//
//  Created by Yusuf Çiftci on 1.01.2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataSource {
    var meal = [MealS]()
    var weeks = ["monday","tuesday","wednesday","thursday","friday", "saturday", "sunday"]
    var day: String!

    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    
    func getMeal(cal: Double, col: UICollectionView) {
        let baseURL = "https://api.spoonacular.com/mealplanner/generate?timeFrame=week&targetCalories=" + String(cal) + "&apiKey=71deb010f36145a39bc36a4d8c9c1115"
        AF.request(baseURL, method: .get, headers: headers).responseJSON { response in
            if let data = response.data, let json = try? JSON(data: data) {
                let meals = json["meals"]
               
                let hafta = json["week"]
                for index in 0...self.weeks.count - 1 {
                    self.day = self.weeks[index]

                    let trueMeal = hafta[self.day]["meals"]
                    for index in 0...trueMeal.count - 1{
                        
                        // Construct image URL
                        let imageUrl = "https://spoonacular.com/recipeImages/" + trueMeal[index]["id"].stringValue + "-" + "312x231" + "." + trueMeal[index]["imageType"].stringValue
                       
                        let newMeal = MealS(day: self.day, id: trueMeal[index]["id"].intValue, title: trueMeal[index]["title"].stringValue, image: imageUrl, imageType: trueMeal[index]["imageType"].stringValue)

                        
                        self.meal.append(newMeal)

                    }

                }
                col.reloadData()
                
            }
        }
        
    }
}
