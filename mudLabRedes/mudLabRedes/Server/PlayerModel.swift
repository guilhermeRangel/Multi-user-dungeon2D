//
//  PlayerModel.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 22/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation
import SpriteKit


struct playersList : Codable{
    var players : [playerModel]? = []
    var countPlayer : Int = 0
}

struct playerModel : Codable {
    var id : String?
    var position : CGPoint?
    var stateDungeon : Int?
    var key : Bool?
    var cores : Int?
 

}



