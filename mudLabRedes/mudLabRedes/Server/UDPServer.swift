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
    
    var logicGame : LogicGame?
    var createNodes = CreateNodes()
 
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
            print("o jogador\(newConnection.currentPath)conectou-se")
            
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
        createNodes.initAllNodes(scene: logicGame!, player: logicGame!.player1, ground: logicGame!.ground, misturador: logicGame!.misturador,
                                 dorEsq: logicGame!.dorEsq, dorDir: logicGame!.dorDir, dorBaixo: logicGame!.dorBaixo, dorCima: logicGame!.dorCima)
        createNodes.createPlayer2(scene: logicGame!, nodo: logicGame!.player2)
        listener.start(queue: queue)
        
        
        
    }
    
    struct sendAndReceiveMsgsCodable : Codable {
        var playerId: String?
        var points : CGPoint?
        
    }
    
    struct sendAndReceiveMsgsCodableList : Codable {
        var playerKey: [sendAndReceiveMsgsCodable] = []
        
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
                            
                            print("msg recebida : \(ObjId)")
                            
                            if let ObjPosition = dataReceived.points {
                                print("msg recebida Points : \(ObjPosition)")
                                
                                self.logicGame?.movePlayer(points: ObjPosition, name: ObjId)
                                
                                
                                
                            }
                        }
                    }
                    //
                    //                    // self.connected = true
                    
                    if error == nil {
                        //connection.send(content: frame, completion: .idempotent)
                                           var serverResponse = sendAndReceiveMsgsCodableList()
                                           serverResponse.playerKey.append(sendAndReceiveMsgsCodable(playerId: self.logicGame?.player1.name , points: self.logicGame?.player1.position))
                                          
                                           let encoder = JSONEncoder()
                                           
                                           if let encodedData = try? encoder.encode(serverResponse){
                                               connection.send(content: encodedData, completion: .contentProcessed({ (error)  in
                                                   print("Enviado Position Player")
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

