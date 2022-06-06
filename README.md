# todoApp

## 概要
フロントエンドにDart/Flutter、バックエンドにGo/gin、DBにMySqlを用いたtodoアプリ。  
state管理はRedux、ORマッパーはgorm。

## ローカルで実行する際の設定
### todo_api
init.goにdb情報を入力
<pre>
todo_api
└── service  
    └── init.go
</pre>

### todo_app
todoConst.dartにローカルのipアドレスを入力
<pre>
todo_app
└── lib
    └── const
        └── todoConst.dart
</pre>
