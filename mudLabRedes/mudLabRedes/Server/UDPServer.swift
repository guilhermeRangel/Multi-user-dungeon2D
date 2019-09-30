//
//  Servidor.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 16/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation
import Network
import SpriteKit

class UDPServer {
    
    var listener : NWListener
    var queue : DispatchQueue
    var connected : Bool = false
    var serverResponse = sendAndReceiveMsgsCodableList()
    
    var logicGame : LogicGame?
    
    
    init?(scene: LogicGame) {
        
        logicGame = scene
        
        queue = DispatchQueue(label: "UDP Server Queue")
        //create the listener
        listener = try! NWListener(using: .udp, on: .http)
        listener.service = NWListener.Service(name: "serverMUD", type: "_http._udp", domain: "local", txtRecord: nil)
        listener.serviceRegistrationUpdateHandler = { (serviceChange) in
            
            print("registrando serviços \(serviceChange)")
            switch (serviceChange) {
            case .add(let endpoint):
                switch endpoint {
                case let .service(name, _, _, _):
                    print("Servidor aberto com o nome - \(name)")
                @unknown default:
                    break
                }
            default:
                break
            }
            
        }
        
        
        //handle incoming connections
        listener.newConnectionHandler = { [weak self] (newConnection) in
            print("novo player se conectou com o servidor ")
            if let strongSelf = self {
                newConnection.start(queue: strongSelf.queue)
                strongSelf.receive(on: newConnection)
                
            }
            //print("o jogador\(newConnection.currentPath)conectou-se")
            
        }
        
        //handle listener state changes,
        //verifica as mudancas de estados
        
        //1
        listener.stateUpdateHandler = { [weak self] (newState) in
            switch (newState) {
            case .ready:
                print("Servidor conectado na porta : \(self!.listener.port!)")
            case .failed(let error):
                print("Listener failed with error: \(error)")
            default:
                break
            }
        }
        
        //start the listener
        logicGame?.createNodes.initAllNodes(scene: logicGame!, player: logicGame!.player1, ground: logicGame!.ground, misturador: logicGame!.misturador,
                                            dorEsq: logicGame!.dorEsq, dorDir: logicGame!.dorDir, dorBaixo: logicGame!.dorBaixo, dorCima: logicGame!.dorCima, dorBack: logicGame!.dorBack, corSecundariaPorta: logicGame!.corSecundariaDor, corJoin: logicGame!.corJoin)
        logicGame?.createNodes.createPlayer2(scene: logicGame!, nodo: logicGame!.player2)
        
        listener.start(queue: queue)
        
        
        
    }
    
    struct sendAndReceiveMsgsCodable : Codable {
        var playerId: String?
        var points : CGPoint?
        
        
    }
    
    struct sendAndReceiveMsgsCodableList : Codable {
        var playerKey: [sendAndReceiveMsgsCodable] = []
        var playListModel : PlayersList = PlayersList()
    }
    
    
    //receive packets from the other side and push to scren as videos
    func receive(on connection: NWConnection){
        connection.receiveMessage { (content, context, isComplete, error) in
            // Extract your message type from the received context.
            if let frame = content {
                if !self.connected {
                    //connection.send(content: frame, completion: .idempotent)
                    let decoder = JSONDecoder()
                    if let dataReceived = try? decoder.decode(sendAndReceiveMsgsCodable.self, from: frame) {
                        if let ObjId = dataReceived.playerId {
                            
                            if let ObjPosition = dataReceived.points {
                                
                                self.logicGame?.movePlayer(points: ObjPosition, name: ObjId)
                                
                                
                                if ObjId == "player1"{
                                    if self.serverResponse.playerKey.count == 0 {
                                        self.serverResponse.playerKey.append(sendAndReceiveMsgsCodable(playerId: ObjId , points: ObjPosition))
                                        
                                        //popula s model do server para futuros delegates
                                        self.logicGame?.modelPlayer.id = ObjId
                                        self.logicGame?.modelPlayer.position = ObjPosition
                                        self.logicGame?.modelPlayer.key = false
                                        self.logicGame?.modelPlayer.stateDungeon = 0
                                        self.logicGame?.modelPlayer.cores = 0
                                        
                                        self.logicGame?.modelPlayerList.players?.append(self.logicGame!.modelPlayer)
                                        //model para o client
                                        self.serverResponse.playListModel.players?.append(self.logicGame!.modelPlayer)
                                        
                                        
                                    }else{
                                        
                                        //p1 vai ser sempre zero
                                        self.serverResponse.playerKey[0].points = ObjPosition
                                        
                                        //atualiza o status de p1 no lado o server
                                        self.logicGame?.modelPlayerList.players?[0].position = ObjPosition
                                        
                                    }
                                }else if ObjId == "player2"{
                                    if self.serverResponse.playerKey.count == 1 {
                                        self.serverResponse.playerKey.append(sendAndReceiveMsgsCodable(playerId: ObjId, points: ObjPosition))
                                        
                                        //popula s model do server para futuros delegates
                                        self.logicGame?.modelPlayer.id = ObjId
                                        self.logicGame?.modelPlayer.position = ObjPosition
                                        
                                        self.logicGame?.modelPlayer.key = false
                                        self.logicGame?.modelPlayer.stateDungeon = 0
                                        self.logicGame?.modelPlayer.cores = 0
                                        
                                        self.logicGame?.modelPlayerList.players?.append(self.logicGame!.modelPlayer)
                                        
                                    }else if self.serverResponse.playerKey.count == 2{
                                        self.serverResponse.playerKey[1].points = ObjPosition
                                        //atualiza o status de p1 no lado o server
                                        self.logicGame?.modelPlayerList.players?[1].position = ObjPosition
                                    }
                                }
                                
                                
                            }   
                        }
                    }
                    
                    if error == nil {
                        
                        
                        
                        
                        let encoder = JSONEncoder()
                        
                        if let encodedData = try? encoder.encode(self.serverResponse){
                            connection.send(content: encodedData, completion: .contentProcessed({ (error)  in
                                //print("Enviado Position Player")
                                if let error = error {
                                    print("erro ao enviar dados\(error)")
                                }
                            }))
                        }
                        self.receive(on: connection)
                    }
                    
                    
                    
                }else {
                    print("nao deu")
                    print("error do receive")
                    
                }
            }
        }
    }
    
}

