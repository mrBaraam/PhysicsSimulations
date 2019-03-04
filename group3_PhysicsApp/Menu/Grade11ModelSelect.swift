//
//  Grade11ModelSelect.swift
//  group3_PhysicsApp
//
//  Created by Period Three on 2018-11-19.
//  Copyright © 2018 Period Three. All rights reserved.
//

import Foundation
import UIKit

class Grade11ModelSelect: UITableViewController{
    
    let physicsSimulationArray  = ["Thermal Energy", "Kinetic Energy", "Static anc Kinetic Friction", "Electricity, Magnet & Circuits", "Projectile Motion"]
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return physicsSimulationArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "physicsSimulation", for: indexPath)
        
        cell.textLabel?.text = physicsSimulationArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "thermalEnergy", sender: nil)
        }
        if indexPath.row == 1{
            performSegue(withIdentifier: "carFriction", sender: nil)

        }
        if indexPath.row == 2 {
            performSegue(withIdentifier: "Friction", sender: nil)
        }
        if indexPath.row == 3 {
            performSegue(withIdentifier: "Magnet", sender: nil)
        }
        if indexPath.row == 4 {
            
           // self.dismiss(animated: true, completion: nil)
            
            performSegue(withIdentifier: "Projectile", sender: nil)
            
        }
    }
    
   
    @IBAction func unwindToPhysicsManu(segue: UIStoryboardSegue) {
       
            
        
        
        
    }
    
    
}
