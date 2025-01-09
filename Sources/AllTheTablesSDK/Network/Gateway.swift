//
//  Gateway.swift
//  AllTheTablesSDK
//
//  Created by Rich Mucha on 27/06/2024.
//

import Foundation
import UIKit

public let kSlowConnectionWaitThreshold: TimeInterval = 4

public protocol GatewayObserver: AnyObject {
    func gatewayUpdatedConnectionStatusUpdated()
    func gatewayReceivedUnauthorisedRequest()
}

public class Gateway: Service {
    
    fileprivate struct _GatewayObserver {
        weak var observer: GatewayObserver?
        
        var isValid: Bool {
            return observer != nil
        }
    }
    
    /**
     Appends a `GatewayObserver` delegate to the Singleton store
     */
    public class func startObserving(
        _ observer: GatewayObserver) {
            let obs = _GatewayObserver(observer: observer)
            observers.append(obs)
        }
    
    /**
     Removes a `GatewayObserver` delegate from the Singleton store
     */
    public class func stopObserving(
        _ observer: GatewayObserver) {
            var idx: Int?
            for (i, wrapper) in observers.enumerated() {
                if wrapper.isValid && wrapper.observer === observer {
                    idx = i
                    break
                }
            }
            
            if let index = idx {
                observers.remove(at: index)
            }
        }
    
    // ==========================================
    // MARK: Properties
    // ==========================================
    
    /// Observers connected to the handler
    static private var observers: [_GatewayObserver] = []
    
    public var rootURL = ""
    
    public var headers: [String: String] = [
//        "x-api-key": AllTheTablesService.apiKey ?? "",
        "x-partner-id": AllTheTablesService.partnerId ?? "",
        "x-public-key": AllTheTablesService.publicKey ?? "",
        "x-app-version": Bundle.main.object(
            forInfoDictionaryKey: kCFBundleVersionKey as String
        ) as? String ?? "",
        "x-device-manufacturer": "Apple",
        "x-device-name": UIDevice.current.name,
        "x-device-os": UIDevice.current.systemVersion,
        "x-device-serial-number": UIDevice.current.identifierForVendor?.uuidString ?? ""
    ]
    
    public let networkQueue = OperationQueue()
    
    // ==========================================
    // MARK: Singleton
    // ==========================================
    
    public static let shared = Gateway()
    
    private init() {
        // TODO: Initialise Groups if required, not confirmed
    }
    
    private static var _lowConnectionNotificationShown: Bool = false {
        didSet {
            observers.forEach {
                $0.observer?.gatewayUpdatedConnectionStatusUpdated()
            }
        }
    }
    
    public static var lowConnectionNotificationShown: Bool {
        get {
            return _lowConnectionNotificationShown
        }
        set {
            _lowConnectionNotificationShown = newValue
        }
    }
    
    // ==========================================
    // MARK: Helpers
    // ==========================================
    
    public func post(
        _ request: Request,
        completion: OperationResponse? = nil) {
            wrapResponse(.post, request, completion: completion)
        }
    
    public func get(
        _ request: Request,
        completion: OperationResponse? = nil) {
            wrapResponse(.get, request, completion: completion)
        }
    
    public func delete(
        _ request: Request,
        completion: OperationResponse? = nil) {
            wrapResponse(.delete, request, completion: completion)
        }
    
    public func put(
        _ request: Request,
        completion: OperationResponse? = nil) {
            wrapResponse(.put, request, completion: completion)
        }
    
    public func patch(
        _ request: Request,
        completion: OperationResponse? = nil) {
            wrapResponse(.patch, request, completion: completion)
        }
    
    // ==========================================
    // MARK: Private Helpers
    // ==========================================
    
    private func wrapResponse(
        _ method: HTTPMethod,
        _ request: Request,
        completion: OperationResponse? = nil) {
            var timer: Timer?
            let startDate = Date()
            
            if !Gateway.lowConnectionNotificationShown && completion != nil {
                timer = Timer.scheduledTimer(
                    withTimeInterval: kSlowConnectionWaitThreshold,
                    repeats: false,
                    block: { _ in
                        if !Gateway.lowConnectionNotificationShown {
                            Gateway.lowConnectionNotificationShown = true
                        }
                    }
                )
            }
            
            makeRequest(method, request: request) { response in
                timer?.invalidate()
                if Date().timeIntervalSince(startDate) < kSlowConnectionWaitThreshold/2 {
                    Gateway.lowConnectionNotificationShown = false
                }
                
                if
                    let error = response.error,
                    (error.code == 403) && NetworkStatusService.hasConnection {
                    Gateway.observers.forEach {
                        $0.observer?.gatewayReceivedUnauthorisedRequest()
                    }
                }
                
                completion?(response)
            }
        }
    
}
