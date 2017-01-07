//
//  AlarmFireBaseGateway.swift
//  share_alarm
//
//  Created by suzukiryota on 2016/12/30.
//  Copyright © 2016年 Mizuki Shimato. All rights reserved.
//

import Foundation
import FirebaseDatabase

class AlartFilebase {
    let dbref: FIRDatabaseReference
    init() {
        dbref = FIRDatabase.database().reference(withPath: "/alarm")
    }
    func store(_ alarm: Alarm, userId: String) -> String {
        let key = dbref.childByAutoId().key
        dbref.child(userId).child(key).setValue(alarm.set(id: key).toHash())
        return key
    }
    
    func updateUserStatus(userId: String, alarm: Alarm, user: JoinedUser) {
        dbref.child(userId).child(alarm.id!).child("joinedUsers").child(user.id).setValue(user.toHash())
    }
    
    func get(id: String, userId: String, cb: @escaping (Alarm?) -> Void) {
        dbref.child(userId).child(id).observeSingleEvent(of: .value, with: { (db) in
            let alarm = AlartFilebase.toModel(db.value as! Dictionary<String, AnyObject>)
            cb(alarm)
        })
    }
    
    func get(userId: String, cb: @escaping ([Alarm]) -> Void) {
        dbref.child(userId).observeSingleEvent(of: .value, with: { (db) in
            let dic = db.value as! Dictionary<String, AnyObject>
            cb(dic.flatMap({ model in
                return AlartFilebase.toModel(model.value as! Dictionary<String, AnyObject>)
            }))
        })
    }
    
    func subscribe(userId: String, alarm: Alarm, cb: @escaping ((Alarm?) -> Void)) -> UInt {
        return dbref.child(userId).child(alarm.id!).observe(.value, with: { db in
            cb(AlartFilebase.toModel(db.value as! Dictionary<String, AnyObject>))
        })
    }
    
    func unsubscribe(userId: String, alarm: Alarm, handlerId: UInt) {
        dbref.child(userId).child(alarm.id!).removeObserver(withHandle: handlerId)
    }
    
    static func joinedUserToModel(_ dict: [String: AnyObject]) -> JoinedUser? {
        if let name = dict["name"] as? String, let id = dict["id"] as? String, let status = dict["status"] as? Int {
            return JoinedUser(id: id, name: name, status: JoinedUserStatus(rawValue: (status))!)
        }
        return nil
    }
    
    static func toModel(_ dict: Dictionary<String, AnyObject>) -> Alarm? {
        if
//            let name = dic["name"],
            let id = dict["id"],
            let duration = dict["duration"],
            let vibration = dict["vibration"],
            let musicURL = dict["musicURL"],
            let time = dict["time"]
        {
            let alarm = initialAlarm()
            alarm.id = id as? String
            alarm.musicURL = musicURL as? String

            alarm.duration = Int(duration.stringValue)
            
            switch Int((vibration) as! NSNumber) {
            case 0: alarm.vibration = true
            case 1: alarm.vibration = false
            default: break
            }
            
            alarm.time = Date(timeIntervalSince1970: Double((time) as! NSNumber))
            
            var joinedUsers: [JoinedUser] = []
            
            if let users = dict["joinedUsers"] {
                joinedUsers = (users as! Dictionary<String, AnyObject?>).flatMap { user in
                    return AlartFilebase.joinedUserToModel(user.value as! Dictionary<String, AnyObject>)
                }
            }
            
            alarm.joiendUsers = joinedUsers
            
            return alarm
        }
        
        return nil
    }
}
