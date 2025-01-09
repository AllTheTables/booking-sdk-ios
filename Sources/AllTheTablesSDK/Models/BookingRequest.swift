//
//  BookingRequest.swift
//  AllTheTablesSDK
//
//  Created by Rich Mucha on 09/01/2025.
//

/**
 Example
 
 ```json
 "availability": {
     "timeSlot": {
         "provider": "designMyNight",
         "requiredDeposit": {
             "amountPer": "guest",
             "currency": "GBP"
         }
     }
 }
 ```
 */

class BookingRequest: Codable {
    
    let availability: Availability
    
}

// TODO: Need to talk to Ollie, doesn't make sense
