//
//  SongController.swift
//  
//
//  Created by Yuyi Wang on 8/28/23.
//

import Vapor
import Fluent

struct SongController : RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        let songs = routes.grouped("songs")
        songs.get(use: index)
        songs.post(use: create)
    }
    
    // GET request: query the database
    func index(req: Request) throws -> EventLoopFuture<[Song]> {
        return Song.query(on: req.db).all()
    }
    
    // EventLoopFuture -> works as async
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let song = try req.content.decode(Song.self)
        return song.save(on: req.db).transform(to: .ok)
    }
}
