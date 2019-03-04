//
//  ViewController.swift
//  Friction_Part
//
//  Created by Period Three on 2018-11-15.
//  Copyright © 2018 Period Three. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var coefficientOfStaticFrictionTextField: UITextField!
    @IBOutlet weak var coefficientOfKineticFrictionTextField: UITextField!
    @IBOutlet weak var massForTheObjectTextField: UITextField!
    @IBOutlet weak var massForTheHungObjectTextField: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var animation: UIButton!
    
    var time = 0
    var timer = Timer()
    
    
    var speed: Double = 0.0
    var globalAcceleration: Double = 0.0
    func calculation(µs: Double, µk: Double, m: Double, h: Double) {
        let Fn = m*9.8
        
        let Fsmax = µs*Fn
        
        let Fk = µk*Fn
       
        let Fg = h*9.8
        
        var acceleration1: Double = 0.0
       
        var tention: Double = 0.0
        var total: Double = 0.0
        var total2: Double = 0.0
        var friction: Double = 0.0
        if Fsmax >= Fg {
       
            friction = Fg
         
            total = 0.0
            total2 = 0.0
        } else if Fsmax < Fg {
           
            friction = Fk
            acceleration1 = (Fg - Fk)/(m+h)
            print(acceleration1)
            
           
            globalAcceleration = acceleration1
            tention = acceleration1*m+Fk
            total = Fg - tention
            total2 = Fg - tention
            
        }
        acceleration = acceleration1
        globalTention = tention
        globalTotal = total
        globalTotal2 = total2
        globalFriction = friction
        normalForce = Fn
    }
    
   let alert = UIAlertController(title: "Sorry", message: "Please check your input", preferredStyle: .alert)

    var excute = false
    func check() {
        if coefficientOfStaticFrictionTextField.text == ""{
            //excute = true
            staticFriction = Double(coefficientOfStaticFrictionTextField.placeholder!)!
            coefficientOfStaticFrictionTextField.text = coefficientOfStaticFrictionTextField.placeholder
            
        }
        
        if coefficientOfKineticFrictionTextField.text == ""{
            //excute = true
            kineticFriction = Double(coefficientOfKineticFrictionTextField.placeholder!)!
            coefficientOfKineticFrictionTextField.text = coefficientOfKineticFrictionTextField.placeholder
        }
        if massForTheObjectTextField.text == "" {
            //excute = true
            massOfCar = Double(massForTheObjectTextField.placeholder!)!
            massForTheObjectTextField.text = massForTheObjectTextField.placeholder
        }
        if massForTheHungObjectTextField.text == "" {
            massOfBlock = Double(massForTheHungObjectTextField.placeholder!)!
            massForTheHungObjectTextField.text = massForTheHungObjectTextField.placeholder
        }
        
        if let s = Double(coefficientOfStaticFrictionTextField.text!), let k = Double(coefficientOfKineticFrictionTextField.text!), let m = Double(massForTheObjectTextField.text!), let m2 = Double(massForTheHungObjectTextField.text!) {
            
            print("check")
            if s >= 0 && k >= 0 && m >= 0 && m2 >= 0 && m2 <= 1600{
                staticFriction = s
                kineticFriction = k
                massOfCar = m
                massOfBlock = m2
                excute = true
            } else {

                present(alert, animated: true)
            }
            
        } else {
            present(alert, animated: true)
        }
       
    }
    
    func clear() {
        coefficientOfStaticFrictionTextField.text = ""
        coefficientOfKineticFrictionTextField.text = ""
        massForTheObjectTextField.text = ""
        massForTheHungObjectTextField.text = ""
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in self.clear()
        }))
        coefficientOfStaticFrictionTextField.placeholder = "\(staticFriction)"
        coefficientOfKineticFrictionTextField.placeholder = "\(kineticFriction)"
        massForTheObjectTextField.placeholder = "\(massOfCar)"
        massForTheHungObjectTextField.placeholder = "\(massOfBlock)"
        excute = false
        
    }


    @IBAction func animation(_ sender: Any) {
        check()
        if excute {
            calculation(µs: staticFriction, µk: kineticFriction, m: massOfCar, h: massOfBlock)
            
        }
        excute = false
        
       // performSegue(withIdentifier: "animation", sender: self)
        self.dismiss(animated: true, completion: nil)
        
       
    }
}

