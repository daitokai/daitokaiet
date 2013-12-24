require 'spec_helper'

describe 'ゆるりと機能一周', js: true do
  before :all do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:twitter, {
      uid: '12345',
      info: {
        nickname: 'daitokai'
      },
      credentials: {
        token: '54321',
        secret: '12345',
      },
    })
  end

  it do
    twitter_client = double('TwitterClient', update: '')
    allow(Twitter::REST::Client).to receive(:new) { twitter_client }

    visit root_path
    all(:link, 'Twitterでログイン').first.click
    expect(current_path).to eq(edit_user_registration_path)

    fill_in '目標体重', with: 60
    click_on '目標体重を変更する'
    expect(current_path).to eq(new_record_path)

    fill_in '体重', with: 70
    fill_in 'コメント(つぶやきます)', with: '今の体重'
    click_on '体重を記録する'
    expect(current_path).to eq(social_path)

    click_on '記録する'
    click_on '戻る'
    click_on '編集'
    click_on '体重を記録する'

    click_on 'ログアウト'
    expect(current_path).to eq(root_path)

    OmniAuth.config.add_mock(:twitter, {
      uid: '54321',
      info: {
        nickname: 'hiroshima'
      },
      credentials: {
        token: '54321',
        secret: '12345',
      },
    })

    all(:link, 'Twitterでログイン').first.click
    expect(current_path).to eq(edit_user_registration_path)

    keypress_script = "$('#user_search').submit();"
    page.driver.browser.execute_script(keypress_script)
    sleep(1)
    expect(current_path).to eq(search_path)

    click_on 'フォローする'
    click_on 'フォロー中'
    click_on 'daitokai'
    expect(current_path).to eq(show_social_path('daitokai'))

    click_on 'フォローする'
    click_on 'みんなの記録'
    expect(current_path).to eq(social_path)

    visit(search_path(q: {name_cont: 'not_found'}))
    expect(page).to have_content '友達がみつかりませんでした!!!!'

    visit(show_social_path('not_found'))
    expect(page).to have_content '友達がみつかりませんでした!!!!'
  end
end
