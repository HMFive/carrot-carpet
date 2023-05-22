//
//  AgeVC.swift
//  CTIS480_Project
//
//  Created by Yusuf Çiftci on 26.12.2022.
//

import UIKit
import CoreData

class AgeVC: UIViewController{

    @IBOutlet weak var mPickerView: UIPickerView!
    
    var selectedRow: Int!
    
    var pickerViewInteracted = false
        
    var ages = Array(13...100)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     selectedRow = mPickerView.selectedRow(inComponent: 0)

      if !pickerViewInteracted {
          let alert = UIAlertController(title: "Age Cannot be Empty", message: "Please Select Your Age", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default))
          present(alert, animated: true, completion: nil)
          
          
      } else {
          if segue.identifier == "age" {
              localUser.age = ages[selectedRow]
          }
      }
    }
}

 extension AgeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
         label.text = ages[row].description
         label.font = UIFont(name: "Helvetica", size: 50)
         
         return label
     }
     func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
         return 50
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return ages[row].description
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return ages.count
     }
     
     func pickerView(_ pickerView: UIPickerView, didSelectRow row:Int, inComponent component: Int) {
         pickerViewInteracted = true
     }
}

