require 'rails_helper'
RSpec.describe 'ユーザー管理機能テスト', type: :system do
  describe 'ユーザー登録機能テスト' do
    context 'ユーザーを新規登録した場合' do
      before do
      end
      it 'ユーザーの新規登録ができる' do
        visit new_user_path
        fill_in '名前',with: 'aaa'
        fill_in 'メールアドレス',with: 'aaa@gmail.com'
        fill_in 'パスワード',with: '123456'
        fill_in '確認用パスワード',with: '123456'
        click_on 'Create my account'
        expect(page).to have_content 'ユーザー登録が完了しました'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        visit new_session_path
      end
    end
  end
  describe 'セッション機能テスト' do
    context 'ログインした場合' do
      it 'ログインができる' do
        visit new_session_path
        fill_in 'Email',with: 'aaa@gmail.com'
        fill_in 'Password',with: '123456'
        click_on 'Log in'
        expect(page).to have_content 'ログインしました'
      end
    end
    context 'ログインした場合' do
      it '詳細ページに遷移する' do
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぶ場合' do
      it 'タスク一覧画面に遷移する' do
      end
    end
    context 'ログインした場合' do
      it 'ログアウトできる' do
      end
    end
  end
  describe '管理画面のテスト' do
     context '管理ユーザは管理画面にアクセスした場合' do
       it '管理ユーザーが管理画面にアクセスできる' do
       end
     end
     context '一般ユーザが管理画面にアクセスした場合' do
       it 'タスク一覧に遷移する' do
       end
     end
     context '管理ユーザはユーザの新規登録した場合' do
       it '管理画面の一覧に遷移する' do

       end
     end
     context '管理ユーザがユーザの詳細画面にアクセスした場合' do
       it 'ユーザーの詳細画面に遷移する' do

       end
     end
     context '管理ユーザはユーザの編集画面にアクセスした場合' do
       it 'ユーザーを編集できる' do

       end
     end
     context '管理ユーザはユーザの削除した場合' do
       it 'ユーザーを削除できる' do

       end
     end
   end
 end
