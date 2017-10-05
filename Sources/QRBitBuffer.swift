import Foundation

struct QRBitBuffer {
    var buffer = [UInt8]()
    private(set) var bitCount = 0
    
    func get(index: Int) -> Bool {
        let bufIndex = index / 8
        return ((buffer[bufIndex] >> (7 - index % 8)) & 1) == 1
    }
    
    subscript(index: Int) -> Bool {
        return get(index: index)
    }
    
    mutating func put(_ num: UInt8, length: Int) {
        for i in 0..<length {
            putBit(((num >> (length - i - 1)) & 1) == 1)
        }
    }
    
    mutating func putBit(_ bit: Bool) {
        let bufIndex = bitCount / 8
        if buffer.count <= bufIndex {
            buffer.append(0)
        }
        if bit {
            buffer[bufIndex] |= (UInt8(0x80) >> UInt8(bitCount % 8))
        }
        bitCount += 1
    }
}
