require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin_user = FactoryBot.create(:admin_user)
    @label1 = FactoryBot.create(:label1)
    @label2 = FactoryBot.create(:label2)
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)

    visit new_session_path
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password
    click_button 'ログイン'
  end

  describe '優先順位での並び変え' do
    context '優先順位でソートするボタンを押した場合' do
      it '優先順位の昇順で表示される' do
        visit tasks_path
        click_on '優先順位でソートする'
        sleep 0.5
        task_list = all('.priority_high')
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
      end
    end
  end
  describe '検索機能' do
   context 'タイトルであいまい検索をした場合' do
     it "検索キーワードを含むタスクで絞り込まれる" do
       visit tasks_path
       fill_in 'タイトル検索',with: 'task'
       click_button 'Search'
       expect(page).to have_content 'task'
     end
   end
   context 'ラベル検索をした場合' do
     it "ラベル検索ができる" do
       visit root_path
        select 'label1', from: 'label_id'
        click_on 'Search'
        expect(page).to have_content 'label1'
      end
    end
   context 'ステータス検索をした場合' do
     it "ステータスに完全一致するタスクが絞り込まれる" do
       visit tasks_path
       select '完了',from: 'ステータス検索'
       expect(page).to have_select('ステータス検索', selected: '完了')
     end
   end
   context 'タイトルのあいまい検索とステータス検索をした場合' do
     it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
       visit tasks_path
       fill_in 'タイトル検索',with: 'task'
       select '完了',from: 'ステータス検索'
       click_button 'Search'
       expect(page).to have_content 'task'
       expect(page).to have_select('ステータス検索', selected: '完了')
     end
   end
 end
 describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_title',with: 'task1'
        fill_in 'task_content',with: 'content1'
        select '2020',from: 'task_limit_date_1i'
        select '11',from: 'task_limit_date_2i'
        select '12',from: 'task_limit_date_3i'
        select '着手中',from: 'task[status]'
        select '高',from: 'task[priority]'
        check 'label1'
        click_button '登録'
        expect(page).to have_content 'task1'
        expect(page).to have_content 'content1'
        expect(page).to have_content '2020'
        expect(page).to have_content '11'
        expect(page).to have_content '12'
        expect(page).to have_content '着手中'
        expect(page).to have_content '高'
        expect(page).to have_content 'label1'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it '終了期限の降順で表示される' do
        visit tasks_path
        click_on '終了期限でソートする'
        sleep 0.5
        task_list = all('.date_row')
        expect(task_list[0]).to have_content '2020-04-02'
        expect(task_list[1]).to have_content '2020-04-01'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'task2'
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task,title: 'task2',content: 'content2',user: @user)
         visit task_path(task.id)
         expect(page).to have_content 'task2'
         expect(page).to have_content 'content2'
       end
     end
  end
end
