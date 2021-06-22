//
//  Constants.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/03/24.
//

import Foundation

struct Constants {
    
    static let encourageMessageList: [String] = [
        "その調子です。",
        "毎日お疲れさまです。",
        "良い一日になりますように。",
        "タスクを楽しみましょう。",
        "いつでもあなたらしく。",
        "ずっと応援しています。",
        "疲れたら休憩しましょう。",
        "アプリを使ってくれてありがとう。",
        "目を覚ますなら、朝シャンがおすすめです。",
        "目を使いすぎると、頭が凝るみたいです。",
        "今日いいことはありましたか？",
        "Eigowoshabereruyouni Naritaina.",
        "毎日の温かいお風呂に感謝。"
    ]
    
    static let adUnitID = "ca-app-pub-9827752847639075/4604400705"

}

enum VCType {
    
    case top
    case showList
    case textInput
    case setting
    case whatIs
    case twitter
    case showSum
    
    var navigationTitle: String {
        
        switch self {
        case .top: return "TOP"
        case .showList: return "タスク一覧"
        case .textInput: return "明日のタスクを設定する"
        case .setting: return "設定"
        case .whatIs: return "アイビーリーメソッドとは？"
        case .twitter: return "Twitter"
        case .showSum: return "これまでに完了したタスク"
        }
    }
}

