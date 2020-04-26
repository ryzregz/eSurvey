//
//  DBManager.swift
//  I&M Survey
//
//  Created by Eclectics on 25/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import RealmSwift
class DBManager{
    private var   database:Realm
    static let   sharedInstance = DBManager()
    private init() {
        database = try! Realm()
    }
    func getUsers() ->   Results<User> {
        let results: Results<User> =   database.objects(User.self)
        return results
    }
    
    func getQuestions() ->   Results<Question> {
        let results: Results<Question> =   database.objects(Question.self)
        return results
    }
    func addUser(object: User)   {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    
    func addQuestions(object: Question)   {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    
    func addSurvey(object: Survey)   {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    func deleteAllFromDatabase()  {
        try!   database.write {
            database.deleteAll()
        }
    }
    func deleteUser(object: User)   {
        try!   database.write {
            database.delete(object)
        }
    }
    
    func deleteQuestion(object: Question)   {
        try!   database.write {
            database.delete(object)
        }
    }


}
