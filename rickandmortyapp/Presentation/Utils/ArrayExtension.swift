//
//  ArrayExtension.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

extension Array where Element == Int {
    func groupConsecutiveNumbers() -> [[Int]] {
        guard !self.isEmpty else { return [] }
        var result: [[Int]] = []
        var currentGroup: [Int] = [self[0]]
        for i in 1..<self.count {
            if self[i] == self[i - 1] + 1 {
                currentGroup.append(self[i])
            } else {
                result.append(currentGroup)
                currentGroup = [self[i]]
            }
        }
        result.append(currentGroup)
        return result
    }
    
    func toRangeStrings() -> [String] {
        let groupedNumbers = groupConsecutiveNumbers()
        return groupedNumbers.map { group in
            if let first = group.first, let last = group.last {
                return first == last ? "\(first)" : "\(first)-\(last)"
            }
            return ""
        }
    }
}
