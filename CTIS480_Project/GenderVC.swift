//
//  GenderVC.swift
//  CTIS480_Project
//
//  Created by Yusuf Çiftci on 26.12.2022.
//

import UIKit
import CoreData

class GenderVC: UIViewController {
    
    
    @IBOutlet weak var buttonFemale: UIButton!
    @IBOutlet weak var buttonMale: UIButton!
    var gender: String!
    
    @IBAction func onMaleButtonClick(_ sender: UIButton) {
        gender = buttonMale.accessibilityIdentifier!
    }
    
    @IBAction func onFemaleButtonClick(_ sender: UIButton) {
        gender = buttonFemale.accessibilityIdentifier!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if gender == nil {
            let alert = UIAlertController(title: "Please Choose a Gender", message: "They say there are more than two genders", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        } else {
            if segue.identifier == "gender" {
                localUser.gender = gender        }
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
