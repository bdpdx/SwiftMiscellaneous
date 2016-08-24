import Foundation

// arc4random_normal() returns a pair of random numbers less than upperBound (use either one or both as needed).
// The return values are mapped to the positive side of a normal (Gaussian) distribution with mean of zero and
// standard deviation of one.
func arc4random_normal(upperBound: UInt32 = UInt32.max) -> (UInt32, UInt32) {
    guard upperBound > 0 else { return (0, 0) }

    let maxUInt32MinusOne = Double(UInt32.max - 1)

    var x0, x1, w: Double

    // Polar Box-Muller Transformation

    repeat {
        x0 = 2.0 * (Double(arc4random_uniform(UInt32.max)) / maxUInt32MinusOne) - 1.0
        x1 = 2.0 * (Double(arc4random_uniform(UInt32.max)) / maxUInt32MinusOne) - 1.0
        w = x0 * x0 + x1 * x1
    } while w >= 1.0

    w = sqrt((-2.0 * Darwin.log(w)) / w)

    let y0 = x0 * w
    let y1 = x1 * w

    // Clamp maximum value to six sigma, map to positive distribution, and return value over [0, upperBound)

    let sixSigma = 6.0
    let upperBoundMinusOne = Double(upperBound) - 1.0

    let y0UInt32 = UInt32(min(abs(y0), sixSigma) / sixSigma * upperBoundMinusOne)
    let y1UInt32 = UInt32(min(abs(y1), sixSigma) / sixSigma * upperBoundMinusOne)
    
    return (y0UInt32, y1UInt32)
}
