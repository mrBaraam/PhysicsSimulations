//
//  InsertVariableView.swift
//  ProjectileMotionSK
//
//  Created by Period Three on 2018-11-26.
//  Copyright © 2018 Period Three. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit
import GameplayKit

class InsertVariableView: UIViewController {
    
    let alert = UIAlertController(title: "Sorry", message: "Gravity should be negative and initial speed should be positive", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        degreeTextField.placeholder = "\(degreeAngle)"
        //degreeTextField.text = "\(degreeAngle)"
        initialTextField.placeholder = "\(initialSpeed / 15)"
        //initialTextField.text = "\(initialSpeed)"
        gravityTextField.placeholder = "\(gravity)"
        //gravityTextField.text = "\(gravity)"
        massTextField.placeholder = "\(mass)"
        //massTextField.text = "\(mass)"
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        
        
    }
    
    var excute = false
    func check() {
        if let d = Double(degreeTextField.text!), let i = Double(initialTextField.text!), let g = Double(gravityTextField.text!), let m = Double(massTextField.text!) {
            
            if d >= 0 && i >= 0 && m > 0{
                degreeAngle = d
                initialSpeed = i * 15
                gravity = g
                mass = m
                excute = true
            } else {
                present(alert, animated: true)
                excute = false
            }
        } else {
            present(alert, animated: true)
            excute = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let d = Double(degreeTextField.text!), let i = Double(initialTextField.text!), let g = Double(gravityTextField.text!), let m = Double(massTextField.text!) {
            
            if d >= 0 && i >= 0 && m > 0.0{
              degreeAngle = d
              initialSpeed = i * 15
              gravity = g
              mass = m
            } else {
                present(alert, animated: true)
            }
        } else {
            present(alert, animated: true)
        }
    }
    
    
    @IBOutlet weak var degreeTextField: UITextField!
    
    @IBOutlet weak var initialTextField: UITextField!
    
    @IBOutlet weak var gravityTextField: UITextField!
    
    @IBOutlet weak var massTextField: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    
    
    
    
    
    
    
    @IBAction func calculateButton(_ sender: Any) {
        
        
        if degreeTextField.text?.isEmpty == true {
            degreeTextField.text = String(degreeAngle)
        }
        
        if initialTextField.text?.isEmpty == true {
            initialTextField.text = String(initialSpeed / 15)
        }
        
        if gravityTextField.text?.isEmpty == true {
            gravityTextField.text = String(gravity)
        }
        
        if massTextField.text?.isEmpty == true {
            massTextField.text = String(mass)
        }
        
        check()
        
        //performSegue(withIdentifier: "test", sender: nil)
        
      self.dismiss(animated: true, completion: nil)
        
     
        
    }
    
}
