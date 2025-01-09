//
//  AllTheTablesService.swift
//  AllTheTablesSDK
//
//  Created by Rich Mucha on 09/01/2025.
//

public class AllTheTablesService {
    
    public enum Environment {
        case production, sandbox
    }
    
    // ==========================================
    // MARK: Properties
    // ==========================================
    
    static var environment: Environment?
    
    static var partnerId: String? {
        didSet {
            Gateway.shared.headers["x-partner-id"] = partnerId
        }
    }
    
    static var publicKey: String? {
        didSet {
            Gateway.shared.headers["x-public-key"] = publicKey
        }
    }
    
    // ==========================================
    // MARK: Helpers
    // ==========================================
    
    /**
     Sets up the AllTheTables SDK for integration with your application.

     Before using the SDK, you must register with our partner portal at [AllTheTables Partner Portal](https://partner.allthetables.com).
     After completing registration, navigate to your settings in the portal to retrieve the required credentials.

     - Parameters:
        - partnerId: A unique `String` identifier provided upon registration, used to authenticate your application.
        - environment: An `Environment` enum value specifying the operating environment (e.g., `production`, `staging`, or `development`).
     
     ### Example
     ```swift
      AllTheTablesSDK.setup(partnerId: "your-partner-id", environment: .production, apiKey: "your-api-key")
     ```
    **/
    public class func setup(
        partnerId: String,
        environment: Environment,
        publicKey: String) {
            self.partnerId = partnerId
            self.environment = environment
            self.publicKey = publicKey
        }
    
}
