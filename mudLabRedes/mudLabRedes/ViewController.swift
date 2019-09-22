//
//  ViewController.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 09/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import UIKit
import Network


class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
   
    var gameViewController : GameViewController?
    var logicGameServer : LogicGame?
    @IBAction func server(_ sender: UIButton) {
        label.text = "SERVER"
        // SERVER
        logicGameServer = LogicGame()
             
        
        
        
    }
    
    @IBAction func client(_ sender: UIButton) {
        label.text = "CLIENT"
        // CLIENT
    
        gameViewController = GameViewController()
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        

        
    }


}




