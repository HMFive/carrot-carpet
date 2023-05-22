//
//  DetailVC.swift
//  
//
//  Created by Yusuf Çiftci on 29.12.2022.
//

import UIKit
import Alamofire
import SwiftyJSON
class DetailVC: UIViewController {

    var image: UIImage!
    //@IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    var recipeId: Int!
    var mtitle: String!
    var nTitle: String!

    @IBOutlet weak var foodTitle: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodImage.image = image
        print(recipeId)
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let baseURL = "https://api.spoonacular.com/recipes/" + String(recipeId) + "/summary?apiKey=71deb010f36145a39bc36a4d8c9c1115"
        AF.request(baseURL, method: .get, headers: headers).responseJSON { response in
            if let data = response.data, let json = try? JSON(data: data) {
                let htmlData = NSString(string: json["summary"].description).data(using: String.Encoding.unicode.rawValue)
                let attributedString = try? NSAttributedString(data: htmlData!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                //testTextView.attributedText = attributedString
                self.foodTitle.attributedText = attributedString
                self.foodTitle.textColor = .white
                self.foodTitle.font = UIFont(name: "Helvetica", size: 16)
                self.foodTitle.textAlignment = .justified

                self.navigationItem.title = self.nTitle
                print(json["summary"])
                
                
                
            }
        }


    }
    



}


