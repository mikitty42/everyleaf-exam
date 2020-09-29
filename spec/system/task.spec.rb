require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '検索機能' do
   before do
     FactoryBot.create(:task, title: "task")
     FactoryBot.create(:second_task, title: "sample")
   end
   context 'タイトルであいまい検索をした場合' do
     it "検索キーワードを含むタスクで絞り込まれる" do
       visit tasks_path
       fill_in 'タイトル検索',with: 'task'
       click_on 'Search'
       expect(page).to have_content 'task'
     end
   end
   context 'ステータス検索をした場合' do
     it "ステータスに完全一致するタスクが絞り込まれる" do
       visit tasks_path
       select '着手',from: 'status'
       expect(page).to have_select('status', selected: '着手')
     end
   end
   context 'タイトルのあいまい検索とステータス検索をした場合' do
     it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
       visit tasks_path
       fill_in 'タイトル検索',with: 'task'
       click_on 'Search'
       select '着手',from: 'status'
       expect(page).to have_content 'task'
       expect(page).to have_select('status', selected: '着手')
     end
   end
 end
  describe '新規作成機能' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_title', with: 'task1'
        fill_in 'task_content', with: 'content1'
        select '2020',from: 'task_limit_date_1i'
        select '11',from: 'task_limit_date_2i'
        select '12',from: 'task_limit_date_3i'
        save_and_open_page
        click_on '登録する'
        expect(page).to have_content 'task1'
        expect(page).to have_content 'content1'
        expect(page).to have_content '2020'
        expect(page).to have_content '11'
        expect(page).to have_content '12'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it '終了期限の降順で表示される' do
        visit tasks_path
        click_on '終了期限でソートする'
        task_list = all('.date_row')
        expect(task_list[0]).to have_content '2020-11-13'
        expect(task_list[1]).to have_content '2020-11-12'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        FactoryBot.create(:task, title: "task")
        FactoryBot.create(:second_task, title: "sample")
        visit tasks_path
        expect(page).to have_content 'task'
        expect(page).to have_content 'sample'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, title: "task")
        FactoryBot.create(:second_task, title: "sample")
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'sample'
        expect(task_list[1]).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         @task = FactoryBot.create(:task,title: 'task1',content: 'content1')
         visit task_path(@task)
         expect(page).to have_content 'task1'
         expect(page).to have_content 'content1'
       end
     end
  end
end
