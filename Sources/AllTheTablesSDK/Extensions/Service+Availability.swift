//
//  Service+Availability.swift
//  AllTheTablesSDK
//
//  Created by Rich Mucha on 09/01/2025.
//

extension Service {
    
    /**
     Fetches the availability for a specific venue.

     This method retrieves an array of availability details for a given venue.
     If availability exists, it will return an array of `Availability` objects.
     In case of an error, the completion handler will provide an appropriate `Error`.

     - Parameters:
        - venueId: A `String` representing the unique identifier of the venue for which availability is being queried.
        - completion: A closure that is executed upon completion of the request.
            - `availability`: An optional array of `Availability` objects if data is successfully retrieved.
            - `error`: An optional `Error` object if the request fails.

     ### Example
     ```swift
     fetchAvailability(for: "venue-id") { availability, error in
         if let error = error {
             print("Error fetching availability: \(error)")
         } else if let availability = availability {
             print("Availability data: \(availability)")
         } else {
             print("No availability found.")
         }
     }
     ```
     */
    func fetchAvailability(
        venueId: String,
        completion: @escaping ([Availability]?, Error?) -> Void) {
            stdGetRequest(
                RequestModel(
                    endpoint: Endpoint.Availability.main.rawValue,
                    endpointParams: [venueId]
                ),
                completion: completion
            )
        }
    
}
