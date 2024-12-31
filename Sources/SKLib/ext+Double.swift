//
//  ext+Double.swift
//  SKLib
//
//  Created by Sravan Karuturi on 12/30/24.
//

extension Double {
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }

    func floor(nearest: Double) -> Double {
        let intDiv = Double(Int(self / nearest))
        return intDiv * nearest
    }
}
