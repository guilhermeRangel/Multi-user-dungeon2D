//
//  PlayerModel.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 22/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation
import SpriteKit


struct playersList{
    var players : [playerModel]? = []
    var countPlayer : Int = 0
}

struct playerModel {
    var player : SKSpriteNode?
    var position : CGPoint?
    var stateDungeon = 0
    var key = false
    var cores = 0
 

}



