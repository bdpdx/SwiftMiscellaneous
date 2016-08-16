func getCurrentWorkingDirectory() -> String {
    var buffer: [Int8] = Array(count: Int(MAXNAMLEN), repeatedValue: 0)
    return String.fromCString(getcwd(&buffer, buffer.count))!
}
