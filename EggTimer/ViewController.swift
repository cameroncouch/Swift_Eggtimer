//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let soft = 5;
    let medium = 8;
    let hard = 12;

    @IBAction func hardnessSelected(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "No Egg")
        var cookTime = 0
        if (sender.currentTitle == "Soft") {
            cookTime = soft
        } 
        else if (sender.currentTitle == "Medium") {
            cookTime = medium
        } 
        else {
            cookTime = hard
        }
        print("Cook time is \(cookTime) mins")
    }
    
}
