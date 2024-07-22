//
//  ext+Result.swift
//  
//
//  Created by Sravan Karuturi on 7/22/24.
//

extension Result {
    
    public var successValue: Success? {
        
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
        
    }
    
    public var failureError: Failure? {
     
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
        
    }
    
}
