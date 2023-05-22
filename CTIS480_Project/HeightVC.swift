//
//  HeightVC.swift
//  CTIS480_Project
//
//  Created by Yusuf Çiftci on 26.12.2022.
//

import UIKit

class HeightVC: UIViewController {
    
    @IBOutlet weak var mPickerView: UIPickerView!
    var heights = Array(110...220)
    
    var pickerViewInteracted = false
    
    var selectedRow: Int!
    
    var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        selectedRow = mPickerView.selectedRow(inComponent: 0)
        
        if !pickerViewInteracted {
            let alert = UIAlertController(title: "Height Cannot be Empty", message: "Please Select a Height", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert,animated: true, completion: nil)
        } else {
            if segue.identifier == "height" {
                
                localUser.height = heights[selectedRow]
            }
        }
         
       
    }
}
extension HeightVC: UIPickerViewDelegate, UIPickerViewDataSource {
   
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
        label.text = heights[row].description
        label.font = UIFont(name: "Helvetica", size: 50)
        
        return label
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return heights[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return heights.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row:Int, inComponent component: Int) {
        pickerViewInteracted = true
    }
}
