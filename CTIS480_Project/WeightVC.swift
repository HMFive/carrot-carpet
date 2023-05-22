//
//  WeightVC.swift
//  CTIS480_Project
//
//  Created by Yusuf Çiftci on 26.12.2022.
//

import UIKit
import CoreData

class WeightVC: UIViewController {
    
    var weights = Array(40...300)
    
    var BMR: Double!
    var pickerViewInteracted = false
    
    var selectedRow: Int!
    
    var mUsers = [User]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var mPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func createUser(name: String, age: Int, gender: String, height: Int, weight: Int) {
        let selectedRow = mPickerView.selectedRow(inComponent: 0)
        
        let newUser = User(context: context)
        newUser.name = localUser.name
        newUser.age = Int32(localUser.age)
        newUser.height = Int32(localUser.height)
        newUser.weight = Int32(weights[selectedRow])
        newUser.gender = localUser.gender
        newUser.bmr = localUser.bmr
        
        fetchData()
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    func calculateBMR(age: Int, gender: String, height: Int, weight: Int) {
        // Mifflin-St Jeor Equation:
        //        For men:
        //        BMR = 10W + 6.25H - 5A + 5
        //        For women:
        //        BMR = 10W + 6.25H - 5A - 161
        if localUser.gender == "male" {
            let w = 10.0 * Double(weights[selectedRow])
            let h = 6.25 * Double(height)
            let a = 5.0 * Double(age)
            
           return localUser.bmr = w + h - a + 5.0
        }
        if localUser.gender == "female"{
            let w = 10.0 * Double(weights[selectedRow])
            let h = 6.25 * Double(height)
            let a = 5.0 * Double(age)
            
           return localUser.bmr = w + h - a - 161.0
            
            
        }
    }
    
    @IBAction func submitData(_ sender: UIButton) {
        calculateBMR(age: localUser.age, gender: localUser.gender, height: localUser.height, weight: localUser.weight)
        createUser(name: localUser.name, age: localUser.age, gender: localUser.gender, height: localUser.height, weight: localUser.weight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        selectedRow = mPickerView.selectedRow(inComponent: 0)
        
        if !pickerViewInteracted {
            let alert = UIAlertController(title: "Weight Cannot be Empty", message: "Please Select a Weight", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert,animated: true, completion: nil)
        } else {
            if segue.identifier == "pass" {
                
                localUser.weight = weights[selectedRow]
                
            }
        }
    }
    
    func fetchData() {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        
        do {
            let results = try context.fetch(request) as! [User]
            for user in results {
                print(user.name, user.age , user.height, user.weight, user.gender)
            }
            
        }
        catch {
            
            // error
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
extension WeightVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        mPickerView.subviews[1].backgroundColor = UIColor(patternImage: UIImage(named: "gra")!).withAlphaComponent(0.5)

        
        label.textColor = .white
        label.textAlignment = .center
        label.text = weights[row].description
        label.font = UIFont(name: "Helvetica", size: 50)
        
        return label
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weights[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weights.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row:Int, inComponent component: Int) {
        pickerViewInteracted = true
    }
}
