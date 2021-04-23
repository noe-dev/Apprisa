//
//  AdminBD.swift
//  AppProveedor
//
//  Created by Labdesarrollo5 on 26/03/21.
//  Copyright © 2021 Labdesarrollo5. All rights reserved.
//

import Foundation
import SQLite3

class AdminBD
{
    let dbPath = "myDB.sqlite"
    var db : OpaquePointer?
    
    init()
    {
        db = openDatabase()
        CreateTableUsr()
        CreateTablePed()
    }
    
    func openDatabase() -> OpaquePointer?
    {
        let archURL = try!  FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        var dbase : OpaquePointer? = nil
        if sqlite3_open(archURL.path, &dbase) != SQLITE_OK
        {
            print("Error al Abrir la Base de Datos")
            return nil
        }
        else
        {
            print("Se Abrio la Base de Datos\(dbPath)")
            return dbase
        }
    }
    
    func CreateTableUsr()
    {
        let CreateTable : String = "CREATE TABLE IF NOT EXISTS Usuario(corrUsr Text PRIMARY KEY, nomUsr Text, contUsr Text)"
        var apuntadorTabla : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, CreateTable, -1, &apuntadorTabla, nil) == SQLITE_OK
        {
            if sqlite3_step(apuntadorTabla) == SQLITE_DONE
            {
                print("Tabla Usuario Creada")
            }
            else
            {
                print("Error: no se creo la tabla de Usuarios")
            }
        }
        sqlite3_finalize(apuntadorTabla)
    }
    
    func CreateTablePed()
    {
        let CreateTable : String = "CREATE TABLE IF NOT EXISTS Pedido(idPed Integer PRIMARY KEY, dirCte Text, dirPed Text, descripcion Text, telefono Integer, fecha Text, extra Text)"
        var apuntadorTabla : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, CreateTable, -1, &apuntadorTabla, nil) == SQLITE_OK
        {
            if sqlite3_step(apuntadorTabla) == SQLITE_DONE
            {
                print("Tabla Pedido Creada")
            }
            else
            {
                print("Error: no se creo la tabla de Pedidos")
            }
        }
        sqlite3_finalize(apuntadorTabla)
    }
    
    func Ejecuta(sentencia : String) -> Bool
    {
        var apuntadorSentencia : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, sentencia, -1, &apuntadorSentencia, nil) == SQLITE_OK
        {
            if sqlite3_step(apuntadorSentencia) == SQLITE_DONE
            {
                print("Se ejecuto la sentecia con Exito")
                sqlite3_finalize(apuntadorSentencia)
                return true
            }
            else
            {
                let errorMsg = String(cString: sqlite3_errmsg(db))
                print("\nQuery is not prepared\(errorMsg)")
                //print("Error no se pudo ejecutar con Exito la sentencia \(sentencia)")
            }
        }
        else
        {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared\(errorMsg)")
            //print("La sentencia no se pudo preparar: \(sentencia)")
        }
        sqlite3_finalize(apuntadorSentencia)
        return false
    }
    
    func Consulta(query : String) -> OpaquePointer?
    {
        var apuntadorQuery : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &apuntadorQuery, nil) == SQLITE_OK
        {
            return apuntadorQuery
        }
        else
        {
            print("Error en la Consulta:\(query)")
            sqlite3_finalize(apuntadorQuery)
            return apuntadorQuery
        }
    }
    
    func Close()
    {
        sqlite3_close(db);
        print("\nSe cerro la base de datos")
    }
    
}
