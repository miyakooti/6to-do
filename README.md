### [🙆‍♀️ appstoreリンクはこちら 🙆‍♀️](https://apps.apple.com/jp/app/6-to-do-%E3%82%A2%E3%82%A4%E3%83%93%E3%83%BC-%E3%83%AA%E3%83%BC-%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E5%BC%8F%E3%82%BF%E3%82%B9%E3%82%AF%E7%AE%A1%E7%90%86%E3%82%A2%E3%83%97%E3%83%AA/id1555816223#?platform=iphone)

<br>
<br>
<br>

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

<br>
<br>
<br>

## 問題点
- どのアーキテクチャにもそれてない
- SettingTableViewControllerがUITableViewをそのままインスタンス化してしまっている。viewControllerのインスタンスをtableViewで拡張するべき。
- ~~６つのタスクのデータの処理が少し分かりづらい。これこそModelを利用して処理するべきだった。下記のような感じで。~~ ←これは修正済み！
~~~
struct sixTasks {
    let taskBody: String?
    let isCompleted: String?
}
~~~
- AlertPresentExtensionの部分など、スコープが小さく名前の寿命が短いにもかかわらず、alertMessageといったふうに名前が細分化されている。
- CountAnimateLabelはextensionで実装できたほうがよい
- 「VCをdismiss→戻ってきたVCから、自動的に別のVCへ遷移」という動きをUserDefaultでやっているのはおかしいと思う
- 一回UserDefaultsの管理方法を大きく変更してアップデートしたところ、クラッシュの報告が大量発生するという大惨事が起きた。これはアップデート後はじめて起動したときは、UserDefaultsをすべて初期化することによって対応した。（あっているのだろうかこれ）
- 

<br>
<br>
<br>

## 改善したこと
- 他のモジュールで利用しないメンバはprivateなどをつけた。
- 責務を分割するために、セルの見た目に関する処理はviewControllerではなく、セルのファイルに書くようにした。
- セルのプロパティにおいてdidSetを利用して、データがセットされると自動的にラベルに反映させるようにした。関数定義するより便利。
- 継承を意図していないクラスは、finalをつけた。
- [storyboardを分割した](https://qiita.com/miyakooti/items/6d1f6368344468e49b0e)
- UITableViewは継承ではなくextensionにすることで、tableViewとUIViewControllerの処理を記述する場所を分割することが出来た。
- 命名規則もろもろ。segueはshowという規則があるらしい。
- アラートの表示やバナーの設定などはextensionで分割
- UserDefaultsのkeyなどは、Stringで暗黙のメンバー参照方式を利用して、タイポ防止。
- if-else文ではなくguard文を利用して、letで定義しつつ早期判定をすることで、コードを短く、見やすくした。
- ライフサイクルの中に見た目や色の設定を書いてしまっていたので、setUpViewsメソッドを別に定義して分割した
- JSONEncoderを利用して、タスクをカスタムクラスで管理するようにした。
- [エンコードの処理をジェネリクスで共通化したので、他のカスタムクラスでもエンコードが利用できるようになった。](https://github.com/miyakooti/myWiki/wiki/JSONEncoder.swift)
- セルのテキストや棒線の処理などは、ViewContollerではなくセルのファイルに書くようにした。
- [ラベルを丸くする](https://github.com/miyakooti/myWiki/wiki/%E6%AD%A3%E6%96%B9%E5%BD%A2%E3%81%AE%E3%83%A9%E3%83%99%E3%83%AB%E3%82%92%E5%86%86%E3%81%AB%E3%81%99%E3%82%8B)、[色を１６進数で初期化する](https://github.com/miyakooti/myWiki/wiki/6%E6%A1%81%E3%81%AE16%E9%80%B2%E6%95%B0%E3%81%A7UIColor%E3%82%92%E5%88%9D%E6%9C%9F%E5%8C%96%E3%81%99%E3%82%8B)等、汎用性の高い機能はExtensionを利用して、再利用できるようにした。
- 16進数からUIColorを返す拡張機能を利用して、ProjectColorというアプリ内で主に使っている色を出力するextensionを作成した。
- 

<br>
<br>
<br>

## これからやってみたいこと
- これまでに完了したタスクを、SNSに共有する機能
- [このqiita記事](https://qiita.com/MaShunzhe/items/ed74b48656729389a6e6)を参考にリファクタリング
- ~~日付ごとに、これまで完了したタスクをリストアップする機能。日付がsectionに対応してて、rowがそれぞれのタスクに対応してる。完了したら、カスタムした構造体の配列のdefaultsに保存していく。~~ ←実装しました

