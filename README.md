|User|
|------|
|name :string|
|email :string|
|password :string|
|password_digest :string|

|Task|
|-------|
|title :string|
|content :text|
|priority :integer|
|status :integer|
|limit_date :date|

|Label|
|--------|
|name :string|

# Herokuへのデプロイ方法  

#### 環境
ruby 2.6.5<br>
rails 5.2.4

1. アセットプリコンパイルをする<br>
  ``$ rails assets:precompile RAILS_ENV=production``
1. コミットする<br>
``~/workspace/heroku_test_app (master) $ git add -A ``
``~/workspace/heroku_test_app (master) $ git commit -m "init"``
1. Herokuに新しいアプリケーションを作成<br>
``$ heroku create``
1.Herokuにデプロイをする<br>
``$ git push heroku master``
