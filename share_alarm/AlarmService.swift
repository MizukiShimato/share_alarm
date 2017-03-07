//
//  AlarmService.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/02/02.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation

private class User {
    let name: String
    let id: String
    init(id: String, name: String) {
        self.name = name
        self.id = id
    }
}

class AlarmService {
    let me: Me
    private let gateway: AlartFilebase
    static func instance() -> AlarmService {
        return AlarmService(me: Me.instance())
    }
    
    private init(me: Me) {
        self.me = me
        self.gateway = AlartFilebase()
    }
    
    func store(_ alarm: Alarm, cb: (String) -> Void) {
        getMe { me in
            let id = gateway.store(alarm, userId: me.id)
            alarm.id = id
            gateway.updateUserStatus(userId: me.id, alarm: alarm, user: JoinedUser(id: me.id, name: me.name, status: JoinedUserStatus.Joined))
            if let id = id {
                cb(id)
            }
        }
    }
    
    func getOne(id: String, userId: String, cb: @escaping (Alarm?) -> Void) {
        getMe {
            me in gateway.get(id: id, userId: userId, cb: cb)
        }
    }
    
    func getList(userId: String, cb: @escaping ([Alarm]) -> Void) {
        getMe {
            me in gateway.get(userId: userId, cb: cb)
        }
    }
    
    func getMyList(cb: @escaping ([Alarm]) -> Void) {
        getMe {
            me in gateway.get(userId: me.id, cb: cb)
        }
    }
    
    func registration(_ alarm: Alarm) {
        getMe { me in
            gateway.updateUserStatus(userId: alarm.userId!, alarm: alarm, user: JoinedUser(id: me.id, name: me.name, status: JoinedUserStatus.Joined))
        }
    }
    
    func changeStateToSleep(_ alarm: Alarm) {
        getMe { me in
            gateway.updateUserStatus(userId: alarm.userId!, alarm: alarm, user: JoinedUser(id: me.id, name: me.name, status: JoinedUserStatus.Sleeping))
        }
    }
    
    func changeStateToWokeup(_ alarm: Alarm) {
        getMe { me in
            gateway.updateUserStatus(userId: alarm.userId!, alarm: alarm, user: JoinedUser(id: me.id, name: me.name, status: JoinedUserStatus.Wokeup))
        }
    }
    
    func subscribe(alarm: Alarm, cb: @escaping ((Alarm?) -> Void)) -> UInt? {
        return getMe { me in
            return gateway.subscribe(userId: me.id, alarm: alarm, cb: cb)
        }
    }
    
    func unsubscribe(alarm: Alarm, handlerId: UInt) {
            gateway.unsubscribe(userId: alarm.userId!, alarm: alarm, handlerId: handlerId)
    }

    
    
    private func getMe<T>(cb: (_ user :User) -> T) -> T? {
        if let name = me.name, let id = me.id {
            return cb(User(id: id, name: name))
        } else {
            return nil
        }
    }
}
