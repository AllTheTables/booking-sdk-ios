//
//  Availability.swift
//  AllTheTablesSDK
//
//  Created by Rich Mucha on 09/01/2025.
//

import Foundation

/**
 Example
 
 ```json
 {
     "provider": "sevenRooms",
     "timeSlot": "18:00",
     "date": "2024-10-04T17:00:00.000Z",
     "url": "https://www.sevenrooms.com/explore/casafofo/reservations/create/search?date=2024-10-04&party_size=2&start_time=18:00",
     "maxDuration": 150,
     "metaData": {
         "sevenRooms": {
             "type": "request",
             "access_persistent_id": "ahNzfnNldmVucm9vbXMtc2VjdXJlchwLEg9uaWdodGxvb3BfVmVudWUYgID2rdOtoAgM-1720795994.624218-0.5917197656369396"
         }
     },
     "dobRequired": false,
     "bookingFormAction": "website"
 }
 ```
 */
struct Availability: Model {
    
    let provider: String
    let timeSlot: String
    let date: Date
    let url: String
    let maxDuration: Int
    let metaData: MetaData
    let dobRequired: Bool
    let bookingFormAction: String
    
    static var storageIdentifier: String {
        return "availability"
    }
    
}

struct MetaData: Codable {
    
    let sevenRooms: SevenRooms
    
}

struct SevenRooms: Codable {
    
    let type: String
    let accessPersistentId: String
    
}
