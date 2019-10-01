require 'rails_helper'

describe 'イベント管理機能', type: :system do
    describe 'イベント一覧画面を表示する機能' do
        #　一連の流れ
        # beforeは、対応するdescribe(context)の領域内のテストコードを実行する前に呼び出されるため、
        #各it毎にまず1番が実行される。この時、before内で login_userって何だ？となる
        
        #次に、遅延評価のletが、login_userを明示するが、（例 let(:login_user) { test_user_a }）
        #test_user_a って何だ？となる。
        
        #次にtest_user_aが定義されている、let(:test_user_a) {～省略～} が呼び出される。
        #最後にit内の処理が実行される
        
        let(:test_user_a) {FactoryBot.create(:user, name: 'test_user_a', mail: 'a@example.com')}
        let(:test_user_b) { FactoryBot.create(:user, name: 'test_user_b', mail: 'b@example.com', password: '123456')}

        before do
          #１番
          FactoryBot.create(:event, name: '最初のイベント', user: test_user_a)
          visit root_path
          find(class: 'log_in').click
          sleep 0.5
          fill_in 'login_mail_field', with: login_user.mail
          fill_in 'login_password_field', with: login_user.password
          click_button 'login_btn'
        end
        
        context 'test_user_aがログインしている時' do 
          let(:login_user) { test_user_a }
          
          it 'test_user_aが作成したイベントが表示される' do 
              expect(page).to have_content '最初のイベント'
          end
        end
        
        context 'test_user_bがログインしている時' do
          let(:login_user) { test_user_b }
          
          it 'test_user_aが作成したイベントは表示されない' do
            expect(page).to have_no_content '最初のイベント'
          end
        end
    end
    
    describe 'イベント作成機能' do 
     let(:test_user_a) {FactoryBot.create(:user, name: 'test_user_a', mail: 'a@example.com')}
     let(:login_user) { test_user_a }
     
      before do 
        visit user_path(login_user)
        find(class: 'create_event_form').click
        sleep 0.5
        fill_in 'イベント名', with: event_name
        allow(controller).to receive(:current_user).and_return(test_user_a)
        #find('create_event_form_user_id', visible: false).set('login_user_id')
        #find('event[event_code]', visible: false).set('87ghz3')
        click_button 'submit_btn'
      end
      
      context 'イベント名を入力した時' do
          let(:event_name) { '新規作成のテストイベント' }
          it 'イベントは正常に登録される' do
            expect(page).to have_selector '.alert-success', text: '新規作成のテストイベント'
          end
      end
      
      context 'イベント名を入力していない時' do
        let(:event_name) { '' }
        it 'イベントは登録されない' do
          within 'error-explanation' do
            expect(page).to have_content 'イベントの作成に失敗しました'
          end
        end
      end
    end
end



