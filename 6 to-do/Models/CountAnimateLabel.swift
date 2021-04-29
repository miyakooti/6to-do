import UIKit

final class CountAnimateLabel: UILabel{

    var startTime: CFTimeInterval!
    var fromValue: Int!
    var toValue: Int!
    var duration: TimeInterval!

    func animate(from fromValue: Int, to toValue: Int, duration: TimeInterval) {
        text = "\(fromValue)個"

        // 開始時間を保存
        self.startTime = CACurrentMediaTime()

        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration

        // CADisplayLinkの生成
        let link = CADisplayLink(target: self, selector: #selector(updateValue))
        link.add(to: .current, forMode: .default)
    }

    // 描画タイミング毎に呼ばれるメソッド
    @objc func updateValue(link: CADisplayLink) {
        // 開始からの進捗 0.0 〜 1.0くらい
        let dt = (link.timestamp - self.startTime) / duration

        // 終了時に最後の値を入れてCADisplayLinkを破棄
        if dt >= 1.0 {
            text = "\(toValue!)個"
            link.invalidate()
            return
        }

        // 最初の値に進捗に応じた値を足して現在の値を計算
        let current = Int(Double(toValue - fromValue) * dt) + fromValue
        text = "\(current)個"
    }
}
