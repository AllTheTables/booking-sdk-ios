//
//  BookingResponse.swift
//  AllTheTablesSDK
//
//  Created by Rich Mucha on 09/01/2025.
//

import Foundation

/**
 Example
 
 ```json
 {
   "booking": {
     "id": "33b40557-9be8-4d1c-b337-04ac3aaeb5f0",
     "dateTime": "2024-10-04T16:30:00.000Z",
     "covers": 2,
     "status": "requested",
     "originalEmail": null,
     "venue": {
       "id": "a01ceac2-eaf4-4c68-bb2f-84402dff0fe3",
       "name": "Casa Fofó",
       "town": "London"
     },
     "tag": "default",
     "users": [
       {
         "id": "820ab5d0-6126-4b62-a72f-24f6125e429c",
         "isOwner": true,
         "email": "ollie@allthetables.com",
         "phone": "+44 7595 510472",
         "firstName": "ollie",
         "lastName": "mahoney"
       }
     ],
     "bookedAt": "2024-10-01T12:51:14.593Z",
     "partner": {
       "id": "f1e7c5f6-cd86-4cb3-8ff2-71a301107dd1",
       "name": "Salamanca",
       "logoUrl": "https://s3.eu-west-2.amazonaws.com/att-venue-images/80309a18-2e36-4c63-9eb8-f4d63fdec7e7-1719840979906.png"
     }
   }
 }
 ```
 */
struct BookingResponse: Model {
    
    let booking: Booking
    
    static var storageIdentifier: String {
        return "booking_response"
    }
    
}

struct Booking: Codable {
    
    let id: String
    let dateTime: Date
    let covers: Int
    let status: String
    let originalEmail: String?
    let venue: Venue
    let tag: String
    let users: [User]
    let bookedAt: Date
    let partner: Partner
    
}

struct Venue: Codable {
    
    let id: String
    let name: String
    let town: String
    
}

struct User: Codable {
    
    let id: String
    let isOwner: Bool
    let email: String
    let phone: String
    let firstName: String
    let lastName: String
    
}

struct Partner: Codable {
    
    let id: String
    let name: String
    let logoUrl: String
    
}

    
