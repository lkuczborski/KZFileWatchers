//
//  Common.swift
//  KZFileWatchers
//
//  Created by Krzysztof Zabłocki on 05/08/16.
//
//

import Foundation

public enum FileWatcher {
    
    /**
     Errors that can be thrown from `FileWatcherProtocol`
     */
    public enum Error: ErrorType {
        
        /**
         Trying to perform operation on watcher that requires started state.
         */
        case notStarted
        
        /**
         Trying to start watcher that's already running.
         */
        case alreadyStarted
        
        /**
         Trying to stop watcher that's already stopped.
         */
        case alreadyStopped
        
        /**
         Failed to start the watcher, `reason` will contain more information why.
         */
        case failedToStart(reason: String)
    }
    
    /**
     Enum that contains status of refresh result.
     */
    public enum RefreshResult {
        /**
         Watched file didn't change since last update.
         */
        case noChanges
        
        /**
         Watched file did change change.
         */
        case updated(data: NSData)
    }
    
    /// Closure used for File watcher updates
    public typealias UpdateClosure = (RefreshResult) -> Void
}

/**
 *  Minimal interface all File Watchers have to implement
 */
public protocol FileWatcherProtocol {
    /**
     Starts observing file changes, a file watcher can only have one callback.
     
     - parameter closure: Closure to use for observations.
     
     - throws: `FileWatcher.Error`
     */
    func start(closure: FileWatcher.UpdateClosure) throws
    
    /**
     Stops observing file changes.
          
     - throws: `FileWatcher.Error`
     */
    func stop() throws
}