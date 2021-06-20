//
//  Created by Arai Kousuke on 2021/04/04.
//

import Foundation
import  UIKit

class JsonEncoder {
    
    class func saveItemsToUserDefaults<T: Codable>(list: [T], key: String) {
        let data = list.map { try! JSONEncoder().encode($0) }
        UserDefaults.standard.set(data as [Any], forKey: key)
        UserDefaults.standard.synchronize()
        
    }
    
    class func readItemsFromUserUserDefault<T: Codable>(key: String) -> [T] {
        guard let items = UserDefaults.standard.array(forKey: key) as? [Data] else { return [T]() }
        let decodedItems = items.map { try! JSONDecoder().decode(T.self, from: $0) }
        return decodedItems
    }
    
}
