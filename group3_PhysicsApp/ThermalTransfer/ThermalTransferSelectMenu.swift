//
//  ThermalTransferSelectMenu.swift
//  group3_PhysicsApp
//
//  Created by Period Three on 2018-11-22.
//  Copyright © 2018 Period Three. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class ThermalTransferSelectMenu: UIViewController{
    
    @IBOutlet weak var initialTempField: UITextField!
    
    @IBOutlet weak var lampPowerField: UITextField!
    
    @IBOutlet weak var massField: UITextField!
    
    @IBOutlet weak var backToManuButton: UIButton!
    
    
    
    
    
    let alert = UIAlertController(title: "Sorry", message: "Please check your input", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self}))
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        initialTempField.keyboardType = UIKeyboardType.numbersAndPunctuation
        lampPowerField.keyboardType = UIKeyboardType.numberPad
        massField.keyboardType = UIKeyboardType.numberPad
      

    }
    
    
    
    @IBAction func backToManuButton(_ sender: Any) {
    }
    
    
    @IBAction func iceCubeAction(_ sender: Any) {
        temperatures.removeAll()
        if let initialCheck = Double(initialTempField.text!){
            initialTT = initialCheck
        }
        if let powerCheck = Double(lampPowerField.text!) {
            powerTT = powerCheck
        }
        if let massCheck = Double(massField.text!) {
            massTT = massCheck
        }
        elementTT = String("water")
        
       
        
        check1()
        if executeTT {
            if initialTT != nil && massTT != nil && powerTT != nil {
                
                if initialTT == 0 && water == true{
                    tagTT = 1
                    water = false
                }
                
                if initialTT > 0 && water == true{
                    tagTT = 2
                    water = false
                }
                if initialTT == 100 && gas == true{
                    tagTT = 3
                    gas = false
                }
                if initialTT > 100 {
                   // clear()
                    
                }
                check1()
                if executeTT {
                    
                    elementTT = "water"
                    
                   self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func aluminumAction(_ sender: Any) {
       
        if let initialCheck = Double(initialTempField.text!){
            initialTT = initialCheck
        }
        if let powerCheck = Double(lampPowerField.text!) {
            powerTT = powerCheck
        }
        if let massCheck = Double(massField.text!) {
            massTT = massCheck
        }
        elementTT = String("aluminum")
        
     
        
        check1()
        temperatures.removeAll()
        if executeTT {
            if initialTT != nil && massTT != nil && powerTT != nil {
                
                if initialTT == 0 && water == true{
                    tagTT = 1
                    water = false
                }
                
                if initialTT > 0 && water == true{
                    tagTT = 2
                    water = false
                }
                if initialTT == 100 && gas == true{
                    tagTT = 3
                    gas = false
                }
                if initialTT > 100 {
                    // clear()
                    
                }
                check1()
                if executeTT {
                    elementTT = "aluminum"
                   self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func check1() {
        if let i = Double(initialTempField.text!), let p = Double(lampPowerField.text!), let m = Double(massField.text!) {
            if  p <= 0 || m <= 0 {
                
                present(alert, animated: true)
                
            } else {
                executeTT = true
            }
        } else {
            present(alert, animated: true)
    }
    }
    
   
}
