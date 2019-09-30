//
//  PlayerModel.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 22/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation
import SpriteKit


struct PlayersList : Codable{
    var players : [PlayerModel]? = []
}

struct PlayerModel : Codable {
    var id : String?
    var position : CGPoint?
    var stateDungeon : Int?
    var key : Bool?
    //0- azul
    //1 - vermelho
    //2 - purple
    var cores : Int?
    
    
}

//enum CoresPrimarias {
//    case azul
//    case vermelho
//    case amarelo
//}
//
//
//enum CoresSecundarias {
//    case verde //azul + amarelo
//    case laranja //vermelho+amarelo
//    case roxo //azul+vermelho
//}
//
//enum Duengeon {
//    case zero
//    case esq
//    case dir
//    case baixo
//
//}
