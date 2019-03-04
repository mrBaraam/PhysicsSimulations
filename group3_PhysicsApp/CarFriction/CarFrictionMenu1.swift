//
//  CarFrictionMenu1.swift
//  group3_PhysicsApp
//
//  Created by Steven Egerszegi on 2018-12-16.
//  Copyright © 2018 Period Three. All rights reserved.
//

import UIKit

class CarFrictionMenu1: UIViewController{
    
    var µ1: Double = 0.1
    var m1: Double = 500
    var v1: Double = 10
    var µ2: Double = 0.1
    var m2: Double = 500
    var v2: Double = 10
   
    
    @IBOutlet weak var kineticFriction1: UILabel!
    
    @IBOutlet weak var mass1: UILabel!
    
    @IBOutlet weak var initialSpeed1: UILabel!
    
    @IBOutlet weak var kineticFriction2: UILabel!
    
    @IBOutlet weak var mass2: UILabel!
    
    @IBOutlet weak var initialSpeed2: UILabel!
    
    @IBOutlet weak var displacementOne: UILabel!
    
    @IBOutlet weak var displacementTwo: UILabel!
    
    @IBAction func k1Back(_ sender: Any) {
        let indexO = getValue(arrayIn: kineticCoefficient, tag: "k1")
        if let index = indexO as? Int {
            if index > 0{
                kineticFriction1.text = String(kineticCoefficient[index-1])
                µ1 = Double(kineticFriction1.text!)!
            }
        }
        
    }
    
    @IBAction func k1Forw(_ sender: Any) {
        let indexO = getValue(arrayIn: kineticCoefficient, tag: "k1")
        if let index = indexO as? Int {
            if index < kineticCoefficient.count-1{
                kineticFriction1.text = String(kineticCoefficient[index+1])
                µ1 = Double(kineticFriction1.text!)!
            }
        }
    }
    
    @IBAction func m1Back(_ sender: Any) {
        let indexO = getValue(arrayIn: mass, tag: "m1")
        if let index = indexO as? Int {
            if index > 0{
                mass1.text = "\(String(mass[index-1])) kg"
                var text = mass1.text!
                text.removeLast()
                text.removeLast()
                text.removeLast()
                m1 = Double(text)!
            }
        }
    }
    
    @IBAction func m1Forw(_ sender: Any) {
        let indexO = getValue(arrayIn: mass, tag: "m1")
        if let index = indexO as? Int {
            if index < mass.count-1{
                mass1.text = "\(String(mass[index+1])) kg"
                var text = mass1.text!
                text.removeLast()
                text.removeLast()
                text.removeLast()
                m1 = Double(text)!
            }
        }
    }
    
    
    @IBAction func v1Back(_ sender: Any) {
        let indexO = getValue(arrayIn: initialSpeed, tag: "v1")
        if let index = indexO as? Int {
            if index > 0{
                initialSpeed1.text = "\(String(initialSpeed[index-1])) m/s"
                var text = initialSpeed1.text!
                text.removeLast()
                text.removeLast()
                text.removeLast()
                text.removeLast()
                v1 = Double(text)!
            }
        }
        
    }
    
    @IBAction func v1Forw(_ sender: Any) {
        let indexO = getValue(arrayIn: initialSpeed, tag: "v1")
        if let index = indexO as? Int {
            if index < initialSpeed.count-1{
                initialSpeed1.text = "\(String(initialSpeed[index+1])) m/s"
                var text = initialSpeed1.text!
                text.removeLast()
                text.removeLast()
                text.removeLast()
                text.removeLast()
                v1 = Double(text)!
            }
        }
    }
    
    @IBAction func k2Back(_ sender: Any) {
        let indexO = getValue(arrayIn: kineticCoefficient, tag: "k2")
        if let index = indexO as? Int {
            if index > 0{
                kineticFriction2.text = String(kineticCoefficient[index-1])
                var text = kineticFriction2.text!
                µ2 = Double(text)!
            }
        }
        
    }
    
    @IBAction func k2Forw(_ sender: Any) {
        let indexO = getValue(arrayIn: kineticCoefficient, tag: "k2")
        if let index = indexO as? Int {
            if index < kineticCoefficient.count-1 {
                kineticFriction2.text = String(kineticCoefficient[index+1])
                var text = kineticFriction2.text!
                µ2 = Double(text)!
            }
        }
        
    }
    
    @IBAction func m2Back(_ sender: Any) {
        let indexO = getValue(arrayIn: mass, tag: "m2")
        if let index = indexO as? Int {
            if index > 0 {
                mass2.text = "\(String(mass[index-1])) kg"
                var text = mass2.text!
                text.removeLast()
                text.removeLast()
                text.removeLast()
                m2 = Double(text)!
            }
        }
        
    }
    
    @IBAction func m2Forw(_ sender: Any) {
        let indexO = getValue(arrayIn: mass, tag: "m2")
        if let index = indexO as? Int {
            if index < mass.count-1{
                mass2.text = "\(String(mass[index+1])) kg"
                var text = mass2.text!
                text.removeLast()
                text.removeLast()
                text.removeLast()
                m2 = Double(text)!
            }
        }
        
    }
    
    @IBAction func v2Back(_ sender: Any) {
        let indexO = getValue(arrayIn: initialSpeed, tag: "v2")
        if let index = indexO as? Int {
            if index > 0{
                initialSpeed2.text = "\(String(initialSpeed[index-1])) m/s"
                var text = initialSpeed2.text!
                text.removeLast()
                text.removeLast()
                text.removeLast()
                text.removeLast()
                v2 = Double(text)!
            }
        }
    }
    
    @IBAction func v2Forw(_ sender: Any) {
        let indexO = getValue(arrayIn: initialSpeed, tag: "v2")
        if let index = indexO as? Int {
            if index < initialSpeed.count-1{
                initialSpeed2.text = "\(String(initialSpeed[index+1])) m/s"
                var text = initialSpeed2.text!
                text.removeLast()
                text.removeLast()
                text.removeLast()
                text.removeLast()
                v2 = Double(text)!
            }
        }
    }
    
    func getValue(arrayIn: [Any], tag: String)-> Any{
        
        if let array = arrayIn as? [Int] {
            for i in 0..<array.count{
                if tag == "m1"{
                    var text = mass1.text
                    text?.removeLast()
                    text?.removeLast()
                    text?.removeLast()
                    if mass[i] == Int(text!)!{
                        return i
                    }
                }else if tag == "m2"{
                    var text = mass2.text
                    text?.removeLast()
                    text?.removeLast()
                    text?.removeLast()
                    if mass[i] == Int(text!)!{
                        return i
                    }
                }else if tag == "v1"{
                    var text = initialSpeed1.text
                    text?.removeLast()
                    text?.removeLast()
                    text?.removeLast()
                    text?.removeLast()
                    if initialSpeed[i] == Int(text!)!{
                        return i
                    }
                }else if tag == "v2"{
                    var text = initialSpeed2.text
                    text?.removeLast()
                    text?.removeLast()
                    text?.removeLast()
                    text?.removeLast()
                    if initialSpeed[i] == Int(text!)!{
                        return i
                    }
                }
            }
        }else if let array = arrayIn as? [Double] {
            for i in 0..<array.count{
                if tag == "k1"{
                    let text = kineticFriction1.text
                    print(kineticCoefficient[i])
                    print(Double(text!)!)
                    if kineticCoefficient[i] == Double(text!)!{
                        print(i)
                        return i
                    }
                }else if tag == "k2"{
                    let text = kineticFriction2.text
                    if kineticCoefficient[i] == Double(text!)!{
                        return i
                    }
                }
            }
        }else{
            return "W"
        }
        return "W"
    }
    
    
    let kineticCoefficient = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2]
    let mass = [500,1000,1500,2000,2500,3000,3500,4000]
    let initialSpeed = [10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kineticFriction1.text = "0.1"
        kineticFriction2.text = "0.1"
        mass1.text = "500 kg"
        mass2.text = "500 kg"
        initialSpeed1.text = "10 m/s"
        initialSpeed2.text = "10 m/s"
        displacementOne.text = "0 m"
        displacementTwo.text = "0 m"
        
        
    }
    func displacement(µ: Double, v: Double, label: UILabel) {
        let a = µ*9.8
        let d = -(-(v)*(v))/(2*a)
        label.text = "\(d.rounded()) m"
    }
    
    func displacementV(µ: Double, v: Double) -> Double{
        let a = µ*9.8
        let d = -(-(v)*(v))/(2*a)
        return d.rounded()
    }
    
    @IBAction func calculate(_ sender: Any) {
        displacement(µ: µ1, v: v1, label: displacementOne)
        car1Displacement = displacementV(µ: µ1, v: v1)
        car1Accel = Double(µ1*9.8)
        displacement(µ:µ2, v: v2, label: displacementTwo)
        car2Displacement = displacementV(µ: µ2, v: v2)
        car2Accel = Double(µ2*9.8)
        menuAccessed = true
        car1k = µ1
        car2k = µ2
        car1v = Int(v1)
        car2v = Int(v2)
        self.dismiss(animated: true, completion: nil)
    }
    
}
