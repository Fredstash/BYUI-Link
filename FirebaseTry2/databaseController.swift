//
//  databaseController.swift
//  FirebaseTry2
//
//  Created by Ryan Cox on 4/11/22.
//

import Foundation
import Firebase

struct UserInfo {
   
   let ref: DatabaseReference?
   let key: String
   let fName: String
   let lName: String
   let userName: String
   let password: String
   let email: String
   var completed: Bool
   
   init(key: String, fName: String, lName: String, userName: String, password: String, email: String, completed: Bool) {
      self.ref = nil
      self.key = key
      self.fName = fName
      self.lName = lName
      self.userName = userName
      self.password = password
      self.email = email
      self.completed = completed
   }
   
   init?(snapshot: DataSnapshot) {
      guard
         let value = snapshot.value as? [String: AnyObject],
         let key = value["key"] as? String,
         let fName = value["fName"] as? String,
         let lName = value["lName"] as? String,
         let userName = value["userName"] as? String,
         let password = value["password"] as? String,
         let email = value["email"] as? String,
         let completed = value["completed"] as? Bool
      else {
         return nil
      }
      
      self.ref = snapshot.ref
      self.key = key
      self.fName = fName
      self.lName = lName
      self.userName = userName
      self.password = password
      self.email = email
      self.completed = completed
   }
      func toAnyObject() -> Any {
         return [
            "key": key,
            "fName": fName,
            "lName": lName,
            "userName": userName,
            "password": password,
            "email": email,
            "completed": completed
         ]
      }
}
   
struct GroupInfo {
   
   let ref: DatabaseReference?
   let key : String
   let groupName: String
   let groupLink: String
   let groupDescription: String
   
   init(key: String, groupName: String, groupLink: String, groupDescription: String) {
      self.ref = nil
      self.key = key
      self.groupName = groupName
      self.groupLink = groupLink
      self.groupDescription = groupDescription
   }
   
   init?(snapshot: DataSnapshot) {
      guard
         let value = snapshot.value as? [String: AnyObject],
         let key = value["key"] as? String,
         let groupName = value["groupName"] as? String,
         let groupLink = value["groupLink"] as? String,
         let groupDescription = value["groupDescription"] as? String
      else {
      return nil
      }
      self.ref = snapshot.ref
      self.key = key
      self.groupName = groupName
      self.groupLink = groupLink
      self.groupDescription = groupDescription
   }
   
   func toAnyObject() -> Any {
      return [
         "key": key,
         "groupName": groupName,
         "groupLink": groupLink,
         "groupDescription": groupDescription
      ]
   }
}

struct UserHasGroup {
   let ref: DatabaseReference?
   let userId: String
   let groupId: String
   
   init(userId: String, groupId: String) {
      self.ref = nil
      self.userId = userId
      self.groupId = groupId
   }
   
   init?(snapshot: DataSnapshot) {
      guard
         let value = snapshot.value as? [String: AnyObject],
         let userId = value["userId"] as? String,
         let groupId = value["groupId"] as? String
      else {
      return nil
      }
      self.ref = snapshot.ref
      self.userId = userId
      self.groupId = groupId
   }
   
   func toAnyObject() -> Any {
      return [
         "userId": userId,
         "groupId": groupId
      ]
   }
}

struct Event {
   let ref: DatabaseReference?
   let key: String
   let eventName: String
   let eventLoc: String
   let eventTime: String
   let eventPrice: String
   let groupId: String
   
   init(key: String, eventName: String, eventLoc: String, eventTime: String, eventPrice: String, groupId: String) {
      self.ref = nil
      self.key = key
      self.eventName = eventName
      self.eventLoc = eventLoc
      self.eventTime = eventTime
      self.eventPrice = eventPrice
      self.groupId = groupId
   }
   
   init?(snapshot: DataSnapshot) {
      guard
         let value = snapshot.value as? [String: AnyObject],
         let key = value["key"] as? String,
         let eventName = value["eventName"] as? String,
         let eventLoc = value["eventLoc"] as? String,
         let eventTime = value["eventTime"] as? String,
         let eventPrice = value["eventPrice"] as? String,
         let groupId = value["groupId"] as? String
      else {
         return nil
      }
      
      self.ref = snapshot.ref
      self.key = key
      self.eventName = eventName
      self.eventLoc = eventLoc
      self.eventTime = eventTime
      self.eventPrice = eventPrice
      self.groupId = groupId
   }
      func toAnyObject() -> Any {
         return [
            "key": key,
            "eventName": eventName,
            "eventLoc": eventLoc,
            "eventTime": eventTime,
            "eventPrice": eventPrice,
            "groupId": groupId
         ]
      }
}

struct Tag {
   let ref: DatabaseReference?
   let tagId: String
   let tag: String
   
   init(tagId: String, tag: String) {
      self.ref = nil
      self.tagId = tagId
      self.tag = tag
   }
   
   init?(snapshot: DataSnapshot) {
      guard
         let value = snapshot.value as? [String: AnyObject],
         let tagId = value["tagId"] as? String,
         let tag = value["tag"] as? String
      else {
      return nil
      }
      self.ref = snapshot.ref
      self.tagId = tagId
      self.tag = tag
   }
   
   func toAnyObject() -> Any {
      return [
         "tagId": tagId,
         "tag": tag,
      ]
   }
}

struct UserHasEvent {
   let ref: DatabaseReference?
   let userId: String
   let eventId: String
   
   init(key: String, userId: String, eventId: String) {
      self.ref = nil
      self.userId = userId
      self.eventId = eventId
   }
   
   init?(snapshot: DataSnapshot) {
      guard
         let value = snapshot.value as? [String: AnyObject],
         let userId = value["userId"] as? String,
         let eventId = value["eventId"] as? String
      else {
      return nil
      }
      self.ref = snapshot.ref
      self.userId = userId
      self.eventId = eventId
   }
   
   func toAnyObject() -> Any {
      return [
         "userId": userId,
         "eventId": eventId,
      ]
   }
}

struct UserHasTag {
   let ref: DatabaseReference?
   let userId: String
   let tagId: String
   
   init(userId: String, tagId: String) {
      self.ref = nil
      self.userId = userId
      self.tagId = tagId
   }
   
   init?(snapshot: DataSnapshot) {
      guard
         let value = snapshot.value as? [String: AnyObject],
         let userId = value["userId"] as? String,
         let tagId = value["tagId"] as? String
      else {
      return nil
      }
      self.ref = snapshot.ref
      self.userId = userId
      self.tagId = tagId
   }
   
   func toAnyObject() -> Any {
      return [
         "userId": userId,
         "tagId": tagId,
      ]
   }
}

struct GroupHasEvent {
   let ref: DatabaseReference?
   let groupId: String
   let eventId: String
   
   init(eventId: String, groupId: String) {
      self.ref = nil
      self.eventId = eventId
      self.groupId = groupId
   }
   
   init?(snapshot: DataSnapshot) {
      guard
         let value = snapshot.value as? [String: AnyObject],
         let eventId = value["eventId"] as? String,
         let groupId = value["groupId"] as? String
      else {
      return nil
      }
      self.ref = snapshot.ref
      self.eventId = eventId
      self.groupId = groupId
   }
   
   func toAnyObject() -> Any {
      return [
         "eventId": eventId,
         "groupId": groupId,
      ]
   }
}


struct EventHasTag {
   let ref: DatabaseReference?
   let eventId: String
   let tagId: String
   
   init(eventId: String, tagId: String) {
      self.ref = nil
      self.eventId = eventId
      self.tagId = tagId
   }
   
   init?(snapshot: DataSnapshot) {
      guard
         let value = snapshot.value as? [String: AnyObject],
         let eventId = value["eventId"] as? String,
         let tagId = value["tagId"] as? String
      else {
      return nil
      }
      self.ref = snapshot.ref
      self.eventId = eventId
      self.tagId = tagId
   }
   
   func toAnyObject() -> Any {
      return [
         "eventId": eventId,
         "tagId": tagId,
      ]
   }
}
