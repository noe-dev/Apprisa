//
//  Pedido.swift
//  Apprisa
//
//  Created by Sergio Guerrero Olvera on 21/04/21.
//

import Foundation

class Pedido
{
    var cod : Int = 0
    var dircte : String = ""
    var dirped : String = ""
    var desc : String = ""
    var fec : String = ""
    var tel : Int = 0
    var extra : String = ""
    
    init(Cod : Int, DirCte : String, DirPed : String, Desc : String, Fec : String, Tel : Int, Extra : String)
    {
        self.cod = Cod
        self.dircte = DirCte
        self.dirped = DirPed
        self.desc = Desc
        self.fec = Fec
        self.tel = Tel
        self.extra = Extra
    }
}
