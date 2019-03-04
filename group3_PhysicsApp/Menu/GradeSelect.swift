//
//  GradeSelect.swift
//  group3_PhysicsApp
//
//  Created by Period Three on 2018-11-19.
//  Copyright © 2018 Period Three. All rights reserved.
//

import Foundation
import UIKit

class GradeSelect: UITableViewController {
    
    var subjectArray = ["Grade 11 Physics"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "subject", for: indexPath)
         cell.textLabel?.text = subjectArray[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "grade11", sender: nil)
        }
    }
    
    
    
    @IBAction func unwindToSubjectManu(segue: UIStoryboardSegue) {
        
        
        
        
        
    }
    
}
