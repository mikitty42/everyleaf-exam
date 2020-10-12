require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    @task = FactoryBot.create(:task, title: 'task')
    @task1 = FactoryBot.create(:second_task, title: "sample")
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_like('task')).to include(task)
        expect(Task.title_like('task')).not_to include(second_task)
        expect(Task.title_like('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_is('着手中')).to include(task)
        expect(Task.status_is('完了')).not_to include(second_task)
        expect(Task.status_is('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_like('task')).to include(task)
        expect(Task.title_like('task')).not_to include(second_task)
        expect(Task.title_like('task').count).to eq 1
        expect(Task.status_is('着手中')).to include(task)
        expect(Task.status_is('完了')).not_to include(second_task)
        expect(Task.status_is('着手中').count).to eq 1
      end
    end
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト',content: '')
        expect(task).not_to be_valid
      end
    end
     context 'タスクのタイトルと詳細に内容が記載されている場合' do
       it 'バリデーションが通る' do
         task = Task.new(title: '成功テスト',content: '成功テスト')
         expect(task).to be_valid
       end
     end
  end
end
