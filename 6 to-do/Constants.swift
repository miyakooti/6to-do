//
//  Constants.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/03/24.
//

import Foundation

struct Constants {
    static let encourageMessageList:[String] = ["その調子です。","毎日お疲れさまです。","良い一日になりますように。","タスクを楽しみましょう。","いつでもあなたらしく。","ずっと応援しています。","疲れたら休憩しましょう。","アプリを使ってくれてありがとう。", "目を覚ますなら、朝シャンがおすすめです。", "目を使いすぎると、頭が凝るみたいです。", "今日いいことはありましたか？", "Eigowoshabereruyouni Naritaina.", "毎日の温かいお風呂に感謝。"]
    static let adUnitID = "ca-app-pub-9827752847639075/4604400705"
    
    // 手打ちで管理するとミスりそう
    struct UserDefaultsKey {
        static let fromSeeVCKey = "fromSeeVC"
        static let fromInputVCKey = "fromInputVC"
        static let sixTaskListKey = "sixTaskList"
        static let sumOfCompletionKey = "sumOfCompletion"
        static let SettingOfshowSeeVCKey = "SettingOfshowSeeVC"
    }
    
    struct SegueKey {
        static let showInputVCKey = "showInputVC"
        static let showSeeVCKey = "showSeeVC"
        static let showSettingVCKey = "showSettingTVC"
        
        static let showWhatIsVCKey = "showWhatIsVC"
        static let showTwitterVCKey = "showTwitterVC"
        static let showSumVCKey = "showSumVC"

    }
}
