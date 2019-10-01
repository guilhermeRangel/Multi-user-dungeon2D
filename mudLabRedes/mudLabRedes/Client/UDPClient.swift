//
//  UDPClient.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 18/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation
import Network
import SpriteKit

class UDPClient {
    var connection: NWConnection
    var queue: DispatchQueue
    var playerScene : Any?
    var modelServer : LogicGame?
    var createNodes = CreateNodes()
    var controlEnterPlayer = false
    
    init(scene: GameScene?, scene2: GameScene2?) {
        if scene != nil {
            playerScene = scene
        }else if scene2 != nil {
            playerScene = scene2
        }
        
        queue = DispatchQueue(label: "UDP Client Queue")
        //cria a coneccao
        connection = NWConnection(to: .service(name: "serverMUD", type: "_http._udp", domain: "local", interface: nil), using: .udp)
        
        //status update handler
        connection.stateUpdateHandler = { [weak self] (newState) in
            print("estado: \(newState)")
            switch (newState) {
            case .ready:
                print("pronto para enviar dados")
                
            case .failed(let error) :
                print("falhor \(error)")
            default:
                break
            }
            
        }
        
        initElements()
        connection.start(queue: queue)
    }
    
    func initElements(){
        if let scene = playerScene as? GameScene{
            createNodes.initAllNodes(scene: scene, player: scene.player1, ground: scene.ground, misturador: scene.misturador,
                                     dorEsq: scene.dorEsq, dorDir: scene.dorDir, dorBaixo: scene.dorBaixo, dorCima: scene.dorCima, dorBack: scene.dorBack, corSecundariaPorta: scene.corSecundariaDor, corJoin: scene.corJoin)
            
        }else if let scene2 = playerScene as? GameScene2{
            createNodes.initAllNodes(scene: scene2, player: scene2.player2, ground: scene2.ground, misturador: scene2.misturador,
                                     dorEsq: scene2.dorEsq, dorDir: scene2.dorDir, dorBaixo: scene2.dorBaixo, dorCima: scene2.dorCima, dorBack: scene2.dorBack, corSecundariaPorta: scene2.corSecundariaDor, corJoin: scene2.corJoin)
        }
        
    }
    
    
    func sendInitialFrame(position : CGPoint, node : SKSpriteNode)  {
        //        let helloMessage = "ola mundo 123".data(using: .utf8)
        let helloMsg : UDPServer.sendAndReceiveMsgsCodable = UDPServer.sendAndReceiveMsgsCodable(playerId: node.name, points: node.position)
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(helloMsg) else {return print("erro Encode")}
        
        connection.send(content: data, completion: .contentProcessed({ (error)  in
            print("Dados enviados com sucesso!")
            if let error = error {
                print("erro ao enviar dados\(error)")
            }
        }))
        connection.receiveMessage { (content, context, isComplete, error) in
            // print("got connected")
            // Extract your message type from the received context.
            if content != nil {
                print("dados \(content?.description)")
                
            }
            
        }
    }
    
    
    
    func sendFrame(node : SKSpriteNode) {
        let idAndPosition : UDPServer.sendAndReceiveMsgsCodable = UDPServer.sendAndReceiveMsgsCodable(playerId: node.name, points: node.position)
        let encoder = JSONEncoder()
        guard let frame = try? encoder.encode(idAndPosition) else {return print("erro Encode")}
        connection.send(content: frame, completion: .contentProcessed({ (error)  in
            //  print("Enviado Position Player ok ")
            self.connection.receiveMessage { (content, context, isComplete, error) in
                // print("got connected")

                // Extract your message type from the received context.
                if content != nil {
                    if let frame = content {
                        let decoder2 = JSONDecoder()
                        if let dataReceived = try? decoder2.decode(UDPServer.sendAndReceiveMsgsCodableList.self, from: frame) {
                            
                            if let scene = self.playerScene as? GameScene {
                                //cria o outro player
                                if ((dataReceived.playerKey.count == 2) && (self.controlEnterPlayer == false)){
                                    self.controlEnterPlayer = true
                                    self.createNodes.createPlayer2(scene: scene, nodo: scene.player2)
                                    scene.player2.position = (dataReceived.playerKey.last?.points)!
                                    
                                    
                                }else if dataReceived.playerKey.count == 1 {
                                    //aqui eu pego e atualizo os caras
                                    
                                    if scene.playListModel.players?.count == 0 {
                                        scene.playListModel.players?.append((dataReceived.playListModel.players?.first)!)
                                    }
                                    
                                }else {
                                    scene.playListModel.players? = (dataReceived.playListModel.players)!
                                    scene.player2.position = (dataReceived.playerKey.last?.points)!
                                    
                                }
                                
                                
                                
                            }else if let scene = self.playerScene as? GameScene2 {
                                //cria o outro player
                                if self.controlEnterPlayer == false{
                                    self.controlEnterPlayer = true
                                    self.createNodes.createPlayer2(scene: scene, nodo: scene.player1)
                                    scene.player1.position = (dataReceived.playerKey.first?.points)!
                                    
                                }else{
                                    
                                    scene.player1.position = (dataReceived.playerKey.first?.points)!
                                }
                            }
                            
                            //
                        }else {
                            print("nao deu")
                        }
                        
                        
                    }
                    
                }
                
            }
            if let error = error {
                print("erro ao enviar dados\(error)")
            }
        })
            
            
            
        )
        
        
        
    }
    
    
    
    //send  data
    //Define um bloco no qual as chamadas para enviar e receber são processadas como um lote para melhorar o desempenho.
    func send(frames: [Data]) {
        connection.batch {
            for frame in frames {
                connection.send(content: frame, completion: .contentProcessed({(error) in
                    print("empacotando data \(frame)")
                    if let error = error {
                        print("Send error: \(error)")
                    }
                }))
            }
        }
    }
    
    
}
