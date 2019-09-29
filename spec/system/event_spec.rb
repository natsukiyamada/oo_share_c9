require 'rails_helper'

describe 'イベント管理機能' type: :system do
    describe 'イベント一覧画面を表示する機能' do
        before do
          #test_user_a を作成しておく
          test_user_a = FactoryBot.create(:user, name: 'test_user_a', mail: 'a@example.com')
          #作成者がtest_user_aであるイベントを作成しておく
          FactoryBot.create(:task, name: '最初のイベント', user: test_user_a)
        end
        
        contect 'test_user_aがログインしている時' do 
          before do 
              #test_user_aでログインする
              visit root_path
              
          end
          
          it 'test_user_aが作成したイベントが表示される' do 
              #作成済みのタスクの名称が画面上に表示されていることを確認
          end
        end
    end
end