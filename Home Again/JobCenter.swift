//
//  JobCenter.swift
//  Home Again
//
//  Created by Eric Chang on 2/17/17.
//  Copyright © 2017 Eric Chang. All rights reserved.
//

import Foundation

var jobCenterEndpoint: String = "https://data.cityofnewyork.us/resource/9ri9-nbz5.json"

struct Job {
    
    let borough: String
    let city: String
    let facilityName: String
    let phoneNumber: String
    let state: String
    let streetAddress: String
    let zipCode: String
    
    init (borough: String,  city: String, facilityName: String, phoneNumber: String, state: String,
          streetAddress: String, zipCode: String) {
        self.borough = borough
        self.city = city
        self.facilityName = facilityName
        self.phoneNumber = phoneNumber
        self.state = state
        self.streetAddress = streetAddress
        self.zipCode = zipCode
    }
    
    init?(dictionary: [String: Any]){
        guard let borough = dictionary["borough"] as? String,
            let city = dictionary["city"] as? String,
            let facilityName = dictionary["facility_name"] as? String,
            let phoneNumber = dictionary["phone_number_s"] as? String,
            let state = dictionary["state"] as? String,
            let streetAddress = dictionary["street_address"] as? String,
            let zipCode = dictionary["zip_code"] as? String else {return nil}
        
        self.init(borough: borough, city: city, facilityName: facilityName, phoneNumber: phoneNumber, state: state, streetAddress: streetAddress, zipCode: zipCode)
    }
    
    static func buildJobArray(from data: Data) -> [Job]? {
        var jobArray: [Job] = []
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            // Remember Gabriel you are returning nil because if the Json is not an array of dictionary then my parasing won't do shit for it so I don't want it
            guard let jsonArray = jsonData as? [[String: Any]] else {return nil}
            
            for dictionary in jsonArray {
                
                guard let jobDictionary = Job(dictionary: dictionary) else {continue}
                // I continue here because if I get a dictionary that doesn't meet my model then I want the function to keep running and build an elementArray. However what if i want a model built with a nil value?
                jobArray.append(jobDictionary)
                // dump(jobArray)
            }
            
        } catch {
            print("problem parsing json: \(error)")
        }
        
        return jobArray
    }// end of func
    
    
}