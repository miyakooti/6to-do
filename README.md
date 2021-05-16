### [appstoreリンクはこちら](https://apps.apple.com/jp/app/6-to-do-%E3%82%A2%E3%82%A4%E3%83%93%E3%83%BC-%E3%83%AA%E3%83%BC-%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E5%BC%8F%E3%82%BF%E3%82%B9%E3%82%AF%E7%AE%A1%E7%90%86%E3%82%A2%E3%83%97%E3%83%AA/id1555816223#?platform=iphone)

# 6 to-do 【アイビー・リー・メソッド式タスク管理アプリ‪】‬

6 to-doは、１００年受け継がれているといわれるタスク管理術「アイビー・リー・メソッド」をもとにしたアプリです。
具体的には、アイビー・リー・メソッドは次の６つのステップを意識します。


1.　夜、紙に「明日やるべきこと」を６つ書く

2.　その６つを重要な順に並べる

3.　翌日、その順番に沿ってやるべきことを進める

4.　その日のうちに全部できなくてもキッパリ忘れる

5.　その日の夜も、「明日やるべきこと」を６つ書く

6.　1〜6を毎日繰り返す


私は以前からこの作業を卓上のメモ帳に書いていたのですが、これがスマホでできたら便利だなと思ったときに思いついたアプリです。
シンプルなアプリですが使い勝手がかなりよく作れたため、自分では一番気に入っています。

## 問題点
- どのアーキテクチャにもそれてない
- SettingTableViewControllerがUITableViewをそのままインスタンス化してしまっている。viewControllerのインスタンスをtableViewで拡張するべき。
- ６つのタスクのデータの処理が少し分かりづらい。これこそModelを利用して処理するべきだった。下記のような感じで。
~~~
struct sixTasks {
    let taskBody: String?
    let isCompleted: String?
}
~~~
- AlertPresentExtensionの部分など、スコープが小さく名前の寿命が短いにもかかわらず、alertMessageといったふうに名前が細分化されている。
- CountAnimateLabelはextensionで実装できたほうがよい
- 

## 改善したこと
- 他のモジュールで利用しないメンバはprivateなどをつけた
- storyboardを分割した
- UITableViewは継承ではなくextensionにすることで、tableViewとUIViewControllerの処理を記述する場所を分割することが出来た。
- 命名規則もろもろ。segueはshow
- アラートの表示やバナーの設定などはextensionで分割
- UserDefaultsのkeyなどは、暗黙のメンバー参照方式を利用して、他の人が間違えないようにした
- if-else文ではなくguard文を利用して、コードを短くしつつ見やすくした。
- ライフサイクルの中に見た目や色の設定を書いてしまっていたので、setUpViewsメソッドを別に定義して分割した
- 

## これからやってみたいこと
- これまでに完了したタスクを、SNSに共有する機能
- [このqiita記事](https://qiita.com/MaShunzhe/items/ed74b48656729389a6e6)を参考にリファクタリング
- 
