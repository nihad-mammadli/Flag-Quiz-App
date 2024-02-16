//
//  Flagsdao.swift
//  FindFlagApp
//
//  Created by Nebula on 23.10.23.
//

import Foundation

class Flagsdao {
    var db:FMDatabase?
    
    init() {
        let endpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let DataBaseURL = URL(fileURLWithPath: endpath).appendingPathComponent("flags.db")
        
        db = FMDatabase(path: DataBaseURL.path)
    }
    
    func random5() -> [Flags] {
        var list = [Flags]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM flags ORDER BY RANDOM() LIMIT 5", values: nil)
            
            while rs.next() {
                
                let flag = Flags(flag_id: Int(rs.string(forColumn: "flag_id")!)!, flag_name: rs.string(forColumn: "flag_name")!, flag_image: rs.string(forColumn: "flag_image")!)
                
                list.append(flag)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func random2IncorrectAnswer(flag_id:Int) -> [Flags] {
        var list = [Flags]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM flags WHERE flag_id != ? ORDER BY RANDOM() LIMIT 2", values: [flag_id])
            
            while rs.next() {
                
                let flag = Flags(flag_id: Int(rs.string(forColumn: "flag_id")!)!, flag_name: rs.string(forColumn: "flag_name")!, flag_image: rs.string(forColumn: "flag_image")!)
                
                list.append(flag)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    
}
